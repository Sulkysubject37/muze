const std = @import("std");
const ts = @import("ts/runtime.zig");
const lower = @import("ir/lower.zig").lower;
const Lang = @import("ir/kinds.zig").Lang;
const IR = @import("ir/soa.zig").IR;
const registry = @import("ops/registry.zig");
const match = @import("ops/match.zig");
const splice = @import("patch/splice.zig").splice;

const Adapter = @import("runner/adapter.zig").Adapter;
const sandbox = @import("runner/sandbox.zig");
const classify = @import("runner/classify.zig");
const test_suite = @import("oracle/test_suite.zig");
const tce = @import("oracle/tce.zig");
const json_report = @import("report/json.zig");
const md_report = @import("report/md.zig");

pub fn main(init: std.process.Init) !void {
    const alloc = init.arena.allocator();
    const io = init.io;
    const cwd = std.Io.Dir.cwd();

    var args = try init.minimal.args.iterateAllocator(alloc);
    _ = args.next(); // skip program name

    var tool_name: []const u8 = "samtools";
    var limit: u32 = std.math.maxInt(u32);

    while (args.next()) |a| {
        if (std.mem.eql(u8, a, "--tool")) {
            tool_name = args.next() orelse return error.MissingTool;
        } else if (std.mem.eql(u8, a, "--limit")) {
            limit = try std.fmt.parseInt(u32, args.next() orelse "0", 10);
        }
    }

    const adapter = try Adapter.fromName(tool_name);
    std.debug.print("[muze] tool={s} root={s}\n", .{ adapter.name, adapter.source_root });

    // --- Prepare baseline ---
    var runs_baseline = std.ArrayList(u8).empty;
    defer runs_baseline.deinit(alloc);
    try runs_baseline.appendSlice(alloc, "runs/");
    try runs_baseline.appendSlice(alloc, adapter.name);
    try runs_baseline.appendSlice(alloc, "/baseline");

    var runs_root = std.ArrayList(u8).empty;
    defer runs_root.deinit(alloc);
    try runs_root.appendSlice(alloc, "runs/");
    try runs_root.appendSlice(alloc, adapter.name);

    try cwd.createDirPath(io, runs_root.items);
    if (std.mem.eql(u8, adapter.name, "samtools")) {
        var hts_dst = std.ArrayList(u8).empty;
        defer hts_dst.deinit(alloc);
        try hts_dst.appendSlice(alloc, runs_root.items);
        try hts_dst.appendSlice(alloc, "/htslib");
        sandbox.copyTree(alloc, io, "external/htslib", hts_dst.items) catch {};
        var hts_dst2 = std.ArrayList(u8).empty;
        defer hts_dst2.deinit(alloc);
        try hts_dst2.appendSlice(alloc, runs_root.items);
        try hts_dst2.appendSlice(alloc, "/mutants/htslib");
        sandbox.copyTree(alloc, io, "external/htslib", hts_dst2.items) catch {};

    }


    std.debug.print("[muze] copying source tree -> {s}\n", .{runs_baseline.items});
    try sandbox.copyTree(alloc, io, adapter.source_root, runs_baseline.items);

    // --- Baseline build + smoke ---
    var base_stdout = std.ArrayList(u8).empty;
    defer base_stdout.deinit(alloc);
    try base_stdout.appendSlice(alloc, runs_baseline.items);
    try base_stdout.appendSlice(alloc, "/build.stdout");

    var base_stderr = std.ArrayList(u8).empty;
    defer base_stderr.deinit(alloc);
    try base_stderr.appendSlice(alloc, runs_baseline.items);
    try base_stderr.appendSlice(alloc, "/build.stderr");

    std.debug.print("[muze] baseline build: {s}\n", .{adapter.build_cmd});
    const br = try sandbox.exec(
        alloc, io, adapter.build_cmd, runs_baseline.items,
        adapter.build_timeout_s, base_stdout.items, base_stderr.items,
    );
    if (br.timed_out or br.exit_code != 0) {
        std.debug.print("[muze] baseline build FAILED (exit={d}, sig={d}, timeout={})\n",
            .{ br.exit_code, br.signal, br.timed_out });
        return error.BaselineBuildFailed;
    }

    // --- Parse target files, find matches ---
    var all_matches = std.ArrayList(struct {
        file_path: []const u8,
        m: match.Match,
        source: []const u8,
        op_idx: usize,
    }).empty;
    defer {
        for (all_matches.items) |entry| {
            alloc.free(entry.file_path);
            alloc.free(entry.source);
        }
        all_matches.deinit(alloc);
    }

    for (adapter.source_dirs) |rel_path| {
        var full = std.ArrayList(u8).empty;
        defer full.deinit(alloc);
        try full.appendSlice(alloc, runs_baseline.items);
        try full.appendSlice(alloc, "/");
        try full.appendSlice(alloc, rel_path);

        const source = cwd.readFileAlloc(io, full.items, alloc, @enumFromInt(64 * 1024 * 1024)) catch |err| {
            std.debug.print("[muze] skip {s}: {}\n", .{ rel_path, err }); continue; };

        const parser = ts.ts_parser_new() orelse return error.ParserInitFailed;
        defer ts.ts_parser_delete(parser);

        const lang_fn = switch (adapter.lang) {
            .c   => ts.tree_sitter_c(),
            .cpp => ts.tree_sitter_cpp(),
            .rust=> ts.tree_sitter_rust(),
        };
        if (!ts.ts_parser_set_language(parser, lang_fn))
            return error.LanguageMismatch;

        const tree = ts.ts_parser_parse_string(
            parser, null, source.ptr, @intCast(source.len),
        ) orelse continue;
        defer ts.ts_tree_delete(tree);

        const root = ts.ts_tree_root_node(tree);

        var arena = std.heap.ArenaAllocator.init(alloc);
        defer arena.deinit();
        var ir = try lower(&arena, root, adapter.lang, source);

        var matches = try match.findMatches(alloc, &ir, &registry.all);
        defer matches.deinit(alloc);
        var deduped = try match.dedupeOverlaps(alloc, matches);
        defer deduped.deinit(alloc);

        std.debug.print("[muze] {s}: {d} matches\n", .{ rel_path, deduped.items.len });

        const file_path_copy = try alloc.dupe(u8, rel_path);
        for (deduped.items) |m| {
            // Which operator matched?
            var op_idx: usize = 0;
            for (registry.all, 0..) |op, oi| {
                if (op.predicate(&ir, m.node_idx)) { op_idx = oi; break; }
            }
            try all_matches.append(alloc, .{
                .file_path = file_path_copy,
                .m = m,
                .source = try alloc.dupe(u8, source),
                .op_idx = op_idx,
            });
        }
    }

    std.debug.print("[muze] total matches: {d}\n", .{all_matches.items.len});

    // --- Generate and run mutants ---
    var records = std.ArrayList(json_report.MutantRecord).empty;
    defer records.deinit(alloc);

    var killed: u32 = 0;
    var survived: u32 = 0;
    var invalid: u32 = 0;
    var timed_out: u32 = 0;

    var mutant_id: u32 = 0;
    var baseline_hashes = std.StringHashMap([32]u8).init(alloc);
    defer baseline_hashes.deinit();
    var tce_discard: u32 = 0;
    
    for (all_matches.items) |entry| {
        // limit removed

        const op = registry.all[entry.op_idx];

        // Mutant dir
        var mutant_dir = std.ArrayList(u8).empty;
        defer mutant_dir.deinit(alloc);
        try mutant_dir.appendSlice(alloc, runs_root.items);
        try mutant_dir.appendSlice(alloc, "/mutants/");
        try mutant_dir.appendSlice(alloc, try std.fmt.allocPrint(alloc, "{d}", .{mutant_id}));

        try sandbox.copyTree(alloc, io, runs_baseline.items, mutant_dir.items);

        // Splice mutated source and overwrite the file in the mutant dir.
        const mutant_source = try splice(alloc, entry.source, entry.m, op.replacement);
        defer alloc.free(mutant_source);

        var target_file = std.ArrayList(u8).empty;
        defer target_file.deinit(alloc);
        try target_file.appendSlice(alloc, mutant_dir.items);
        try target_file.appendSlice(alloc, "/");
        try target_file.appendSlice(alloc, entry.file_path);

        try cwd.writeFile(io, .{
            .sub_path = target_file.items,
            .data = mutant_source,
        });

        std.debug.print("[muze] mutant {d}: {s} {s} (node {d})\n",
            .{ mutant_id, entry.file_path, op.name, entry.m.node_idx });

        var verdict = @import("runner/classify.zig").Verdict.invalid;
        
        // TCE
        const obj_target = try std.fmt.allocPrint(alloc, "{s}o", .{entry.file_path[0 .. entry.file_path.len - 1]});
        defer alloc.free(obj_target);
        
        if (!baseline_hashes.contains(entry.file_path)) {
            const rm_cmd = try std.fmt.allocPrint(alloc, "rm -f {s}", .{obj_target});
            _ = try sandbox.exec(alloc, io, rm_cmd, runs_baseline.items, 10, "/dev/null", "/dev/null");
            alloc.free(rm_cmd);
            
            const base_cmd = try std.fmt.allocPrint(alloc, "make {s} CFLAGS=\"-g -O0\"", .{obj_target});
            _ = try sandbox.exec(alloc, io, base_cmd, runs_baseline.items, 60, "/dev/null", "/dev/null");
            alloc.free(base_cmd);
            
            const base_obj_path = try std.fmt.allocPrint(alloc, "{s}/{s}", .{runs_baseline.items, obj_target});
            defer alloc.free(base_obj_path);
            if (tce.hashFile(alloc, io, cwd, base_obj_path)) |hash| {
                try baseline_hashes.put(entry.file_path, hash);
            } else |err| {
                std.debug.print("[muze] TCE baseline hash fail {s}: {any}\n", .{entry.file_path, err});
            }
        }

        const mut_cmd = try std.fmt.allocPrint(alloc, "make {s} CFLAGS=\"-g -O0\"", .{obj_target});
        defer alloc.free(mut_cmd);
        
        const mut_tce_res = try sandbox.exec(alloc, io, mut_cmd, mutant_dir.items, 60, "/dev/null", "/dev/null");
        
        var tce_eq = false;
        if (mut_tce_res.exit_code == 0) {
            const mut_obj_path = try std.fmt.allocPrint(alloc, "{s}/{s}", .{mutant_dir.items, obj_target});
            defer alloc.free(mut_obj_path);
            if (tce.hashFile(alloc, io, cwd, mut_obj_path)) |mut_hash| {
                if (baseline_hashes.get(entry.file_path)) |base_hash| {
                    if (std.mem.eql(u8, &base_hash, &mut_hash)) {
                        tce_eq = true;
                    }
                }
            } else |_| {}
        }

        if (mut_tce_res.exit_code != 0) {
            verdict = .invalid;
            std.debug.print(" -> invalid\n", .{});
        } else if (tce_eq) {
            tce_discard += 1;
            std.debug.print(" -> tce equivalent\n", .{});
            continue;
        } else {
            verdict = try test_suite.run(alloc, io, adapter, mutant_dir.items, mutant_dir.items);
            std.debug.print(" -> {s}\n", .{@tagName(verdict)});
        }

        switch (verdict) {
            .killed   => killed   += 1,
            .survived => survived += 1,
            .invalid  => invalid  += 1,
            .timeout  => timed_out += 1,
        }

        try records.append(alloc, .{
            .id = mutant_id,
            .file = entry.file_path,
            .operator = op.name,
            .class = @tagName(op.class),
            .op_start = entry.m.op_start,
            .op_end = entry.m.op_end,
            .verdict = @tagName(verdict),
        });

        mutant_id += 1;
    }

    // --- Write reports ---
    const report = json_report.ToolReport{
        .tool = adapter.name,
        .total = mutant_id,
        .killed = killed,
        .survived = survived,
        .invalid = invalid,
        .timeout = timed_out,
        .mutants = records.items,
    };

    var report_json = std.ArrayList(u8).empty;
    defer report_json.deinit(alloc);
    try report_json.appendSlice(alloc, runs_root.items);
    try report_json.appendSlice(alloc, "/report.json");

    var report_md = std.ArrayList(u8).empty;
    defer report_md.deinit(alloc);
    try report_md.appendSlice(alloc, runs_root.items);
    try report_md.appendSlice(alloc, "/report.md");

    try json_report.write(alloc, io, report_json.items, report);
    try md_report.write(alloc, io, report_md.items, report);

    std.debug.print("\n=== {s} DONE ===\n", .{adapter.name});
    std.debug.print("  mutants generated: {d}\n", .{mutant_id});
    std.debug.print("  killed:    {d}\n", .{killed});
    std.debug.print("  survived:  {d}\n", .{survived});
    std.debug.print("  invalid:   {d}\n", .{invalid});
    std.debug.print("  timeout:   {d}\n", .{timed_out});
    std.debug.print("  tce_discard: {d}\n", .{tce_discard});
    std.debug.print("  reports: {s}, {s}\n", .{ report_json.items, report_md.items });
}
