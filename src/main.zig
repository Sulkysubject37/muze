const std = @import("std");
const ts = @import("ts/runtime.zig");
const lower = @import("ir/lower.zig").lower;
const Lang = @import("ir/kinds.zig").Lang;
const IR = @import("ir/soa.zig").IR;
const registry = @import("ops/registry.zig");
const match = @import("ops/match.zig");
const splice = @import("patch/splice.zig").splice;

const ToolAdapter = @import("runner/adapter.zig").ToolAdapter;
const sandbox = @import("runner/sandbox.zig");
const classify = @import("runner/classify.zig");
const test_suite = @import("oracle/test_suite.zig");
const tce = @import("oracle/tce.zig");
const json_report = @import("report/json.zig");
const md_report = @import("report/md.zig");

const WorkerResult = struct {
    records: std.ArrayList(json_report.MutantRecord),
    killed: u32,
    survived: u32,
    invalid: u32,
    timed_out: u32,
    tce_discard: u32,
    baseline_hashes: std.StringHashMap([32]u8),
};

const WorkerContext = struct {
    alloc: std.mem.Allocator,
    io: std.Io,
    adapter: ToolAdapter,
    worker_id: usize,
    runs_root: []const u8,
    runs_baseline: []const u8,
    matches_chunk: []const MatchEntry,
    start_idx: usize,
    res: *WorkerResult,
    csv_lock: *std.atomic.Value(u8),
    tool_name: []const u8,
};

const MatchEntry = struct {
    file_path: []const u8,
    m: match.Match,
    source: []const u8,
    op_idx: usize,
};

fn workerMain(ctx: WorkerContext) void {
    const worker_dir = std.fmt.allocPrint(ctx.alloc, "{s}/workers/w{d}", .{ctx.runs_root, ctx.worker_id}) catch return;
    defer ctx.alloc.free(worker_dir);

    ctx.adapter.initWorker(ctx.alloc, ctx.io, worker_dir, ctx.runs_baseline) catch |err| {
        std.debug.print("worker {d} init failed: {}\n", .{ctx.worker_id, err});
        return;
    };

    for (ctx.matches_chunk, 0..) |entry, i| {
        const op = registry.all[entry.op_idx];
        const mutant_id = ctx.start_idx + i;

        const base_file = std.fmt.allocPrint(ctx.alloc, "{s}/{s}", .{ctx.runs_baseline, entry.file_path}) catch continue;
        const work_file = std.fmt.allocPrint(ctx.alloc, "{s}/{s}", .{worker_dir, entry.file_path}) catch continue;
        defer ctx.alloc.free(base_file);
        defer ctx.alloc.free(work_file);
        
        defer std.Io.Dir.cwd().writeFile(ctx.io, .{ .sub_path = work_file, .data = entry.source }) catch {};

        const mutant_source = splice(ctx.alloc, entry.source, entry.m, op.replacement) catch continue;
        defer ctx.alloc.free(mutant_source);

        std.Io.Dir.cwd().writeFile(ctx.io, .{ .sub_path = work_file, .data = mutant_source }) catch continue;

        var verdict = classify.Verdict.invalid;
        var tce_eq = false;

        var base_hash_opt: ?[32]u8 = null;
        if (ctx.res.baseline_hashes.get(entry.file_path)) |h| {
            base_hash_opt = h;
        } else {
            std.Io.Dir.cwd().writeFile(ctx.io, .{ .sub_path = work_file, .data = entry.source }) catch continue; 
            if (ctx.adapter.compileMutant(ctx.alloc, ctx.io, entry.file_path, worker_dir)) |base_obj| {
                defer ctx.alloc.free(base_obj);
                if (tce.hashFile(ctx.alloc, ctx.io, std.Io.Dir.cwd(), base_obj)) |hash| {
                    ctx.res.baseline_hashes.put(entry.file_path, hash) catch {};
                    base_hash_opt = hash;
                } else |_| {}
            } else |_| {}
            std.Io.Dir.cwd().writeFile(ctx.io, .{ .sub_path = work_file, .data = mutant_source }) catch continue;
        }

        if (ctx.adapter.compileMutant(ctx.alloc, ctx.io, entry.file_path, worker_dir)) |mut_obj| {
            defer ctx.alloc.free(mut_obj);
            if (tce.hashFile(ctx.alloc, ctx.io, std.Io.Dir.cwd(), mut_obj)) |mut_hash| {
                if (base_hash_opt) |base_hash| {
                    if (std.mem.eql(u8, &base_hash, &mut_hash)) {
                        tce_eq = true;
                    }
                }
            } else |_| {}
            
            if (!tce_eq) {
                if (ctx.adapter.linkTarget(ctx.alloc, ctx.io, worker_dir)) |success| {
                    if (success) {
                        verdict = ctx.adapter.runTests(ctx.alloc, ctx.io, worker_dir) catch .invalid;
                    }
                } else |_| {}
            }
        } else |_| {}

        std.debug.print("[muze] mutant {d}: {s} {s} (node {d})", .{ mutant_id, entry.file_path, op.name, entry.m.node_idx });
        if (tce_eq) {
            ctx.res.tce_discard += 1;
            std.debug.print(" -> tce equivalent\n", .{});
        } else {
            std.debug.print(" -> {s}\n", .{@tagName(verdict)});
            switch (verdict) {
                .killed   => ctx.res.killed += 1,
                .survived => ctx.res.survived += 1,
                .invalid  => ctx.res.invalid += 1,
                .timeout  => ctx.res.timed_out += 1,
            }
            
            ctx.res.records.append(ctx.alloc, .{
                .id = @intCast(mutant_id),
                .file = entry.file_path,
                .operator = op.name,
                .class = @tagName(op.class),
                .op_start = entry.m.op_start,
                .op_end = entry.m.op_end,
                .verdict = @tagName(verdict),
            }) catch {};
            
            while (ctx.csv_lock.cmpxchgWeak(0, 1, .acquire, .monotonic) != null) {}
            defer ctx.csv_lock.store(0, .release);
            
            const csv_path = std.fmt.allocPrint(ctx.alloc, "runs/{s}/results.csv", .{ctx.tool_name}) catch continue;
            defer ctx.alloc.free(csv_path);
            
            var file = std.Io.Dir.cwd().openFile(ctx.io, csv_path, .{ .mode = .read_write }) catch blk: {
                var f = std.Io.Dir.cwd().createFile(ctx.io, csv_path, .{ .truncate = false }) catch continue;
                f.writeStreamingAll(ctx.io, "id,file,operator,class,verdict\n") catch {};
                break :blk f;
            };
            defer file.close(ctx.io);
            
            const line = std.fmt.allocPrint(ctx.alloc, "{d},{s},{s},{s},{s}\n", .{
                mutant_id, entry.file_path, op.name, @tagName(op.class), @tagName(verdict)
            }) catch continue;
            defer ctx.alloc.free(line);
            
            if (file.stat(ctx.io)) |stat| {
                file.writePositionalAll(ctx.io, line, stat.size) catch {};
            } else |_| {}
        }
    }
}

fn sortRecords(_: void, a: json_report.MutantRecord, b: json_report.MutantRecord) bool {
    return a.id < b.id;
}
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

    const adapter = try ToolAdapter.fromName(tool_name);
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


    var skip_baseline = false;
    var test_file = std.ArrayList(u8).empty;
    defer test_file.deinit(alloc);
    try test_file.appendSlice(alloc, runs_baseline.items);
    if (std.mem.eql(u8, adapter.name, "gromacs") or std.mem.eql(u8, adapter.name, "iqtree")) {
        try test_file.appendSlice(alloc, "/build/compile_commands.json");
    } else if (std.mem.eql(u8, adapter.name, "bwa")) {
        try test_file.appendSlice(alloc, "/bwa");
    } else {
        try test_file.appendSlice(alloc, "/samtools");
    }
    if (cwd.statFile(io, test_file.items, .{})) |_| {
        skip_baseline = true;
    } else |_| {}

    if (!skip_baseline) {
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

        std.debug.print("[muze] baseline build: {s}\n", .{adapter.baseline_build_cmd});
        const br = try sandbox.exec(
            alloc, io, adapter.baseline_build_cmd, runs_baseline.items,
            adapter.build_timeout_s, base_stdout.items, base_stderr.items,
        );
        if (br.timed_out or br.exit_code != 0) {
            std.debug.print("[muze] baseline build FAILED (exit={d}, sig={d}, timeout={})\n",
                .{ br.exit_code, br.signal, br.timed_out });
            return error.BaselineBuildFailed;
        }
    } else {
        std.debug.print("[muze] baseline already built at {s}, skipping baseline build\n", .{runs_baseline.items});
    }

    // --- Parse target files, find matches ---
    var all_matches = std.ArrayList(MatchEntry).empty;
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

    var bio_count: usize = 0;
    var gen_count: usize = 0;
    for (all_matches.items) |entry| {
        if (registry.all[entry.op_idx].class == .bio) {
            bio_count += 1;
        } else {
            gen_count += 1;
        }
    }
    std.debug.print("[muze] total matches: {d} (bio: {d}, generic: {d})\n", .{ all_matches.items.len, bio_count, gen_count });

        // --- Generate and run mutants ---
    const cpu_count: usize = adapter.max_workers;
    var workers = try alloc.alloc(std.Thread, cpu_count);
    defer alloc.free(workers);
    var results = try alloc.alloc(WorkerResult, cpu_count);
    defer alloc.free(results);

    if (limit != std.math.maxInt(u32) and all_matches.items.len > limit) {
        all_matches.items.len = limit;
    }

    const chunk_size = (all_matches.items.len + cpu_count - 1) / cpu_count;

    var csv_lock = std.atomic.Value(u8).init(0);
    for (0..cpu_count) |i| {
        results[i] = WorkerResult{
            .records = std.ArrayList(json_report.MutantRecord).empty,
            .killed = 0,
            .survived = 0,
            .invalid = 0,
            .timed_out = 0,
            .tce_discard = 0,
            .baseline_hashes = std.StringHashMap([32]u8).init(alloc),
        };
        
        const start = i * chunk_size;
        var end = (i + 1) * chunk_size;
        if (end > all_matches.items.len) end = all_matches.items.len;
        if (start >= all_matches.items.len) {
            end = start;
        }
        
        const ctx = WorkerContext{
            .alloc = alloc,
            .io = io,
            .adapter = adapter,
            .worker_id = i,
            .runs_root = runs_root.items,
            .runs_baseline = runs_baseline.items,
            .matches_chunk = all_matches.items.ptr[start..end],
            .start_idx = start,
            .res = &results[i],
            .csv_lock = &csv_lock,
            .tool_name = tool_name,
        };
        
        workers[i] = std.Thread.spawn(.{}, workerMain, .{ctx}) catch unreachable;
    }


    var records = std.ArrayList(json_report.MutantRecord).empty;
    defer records.deinit(alloc);

    var killed: u32 = 0;
    var survived: u32 = 0;
    var invalid: u32 = 0;
    var timed_out: u32 = 0;
    var tce_discard: u32 = 0;

    for (0..cpu_count) |i| {
        workers[i].join();
        
        killed += results[i].killed;
        survived += results[i].survived;
        invalid += results[i].invalid;
        timed_out += results[i].timed_out;
        tce_discard += results[i].tce_discard;
        
        for (results[i].records.items) |r| {
            records.append(alloc, r) catch unreachable;
        }
        results[i].records.deinit(alloc);
        results[i].baseline_hashes.deinit();
    }

    std.mem.sort(json_report.MutantRecord, records.items, {}, sortRecords);

    const report = json_report.ToolReport{
        .tool = adapter.name,
        .total = @as(u32, @intCast(all_matches.items.len)),
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
    std.debug.print("  mutants generated: {d}\n", .{all_matches.items.len});
    std.debug.print("  killed:    {d}\n", .{killed});
    std.debug.print("  survived:  {d}\n", .{survived});
    std.debug.print("  invalid:   {d}\n", .{invalid});
    std.debug.print("  timeout:   {d}\n", .{timed_out});
    std.debug.print("  tce_discard: {d}\n", .{tce_discard});
    std.debug.print("  reports: {s}, {s}\n", .{ report_json.items, report_md.items });
}
