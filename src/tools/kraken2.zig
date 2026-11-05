const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const ToolAdapter = @import("../runner/adapter.zig").ToolAdapter;
const classify = @import("../runner/classify.zig");
const sandbox = @import("../runner/sandbox.zig");

fn initWorker(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8, baseline_dir: []const u8) anyerror!void {
    const cmd = try std.fmt.allocPrint(alloc, "rm -rf {s} && mkdir -p {s} && cp -a {s}/. {s}/", .{ worker_dir, worker_dir, baseline_dir, worker_dir });
    defer alloc.free(cmd);
    _ = try sandbox.exec(alloc, io, cmd, ".", 120, "/dev/null", "/dev/null");
}

fn compileMutant(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8, worker_dir: []const u8) anyerror![]const u8 {
    var obj_buf: [256]u8 = undefined;
    const len = file_path.len;
    var base_len: usize = len;
    if (std.mem.endsWith(u8, file_path, ".cc")) {
        base_len = len - 3;
    } else if (std.mem.endsWith(u8, file_path, ".cpp")) {
        base_len = len - 4;
    } else if (std.mem.endsWith(u8, file_path, ".c")) {
        base_len = len - 2;
    }
    const obj_file = std.fmt.bufPrint(&obj_buf, "{s}.o", .{file_path[0..base_len]}) catch return error.CompileFailed;

    const rm_cmd = try std.fmt.allocPrint(alloc, "rm -f {s}", .{obj_file});
    defer alloc.free(rm_cmd);
    _ = sandbox.exec(alloc, io, rm_cmd, worker_dir, 10, "/dev/null", "/dev/null") catch {};

    const compile_cmd = try std.fmt.allocPrint(alloc, "c++ -Wall -std=c++11 -O3 -fPIC -g -DLINEAR_PROBING -ffile-prefix-map={s}=. -c -o {s} {s}", .{ worker_dir, obj_file, file_path });
    defer alloc.free(compile_cmd);

    const res = try sandbox.exec(alloc, io, compile_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;

    return std.fmt.allocPrint(alloc, "{s}/{s}", .{ worker_dir, obj_file });
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const link_cmd = "c++ -Wall -std=c++11 -O3 -fPIC -g -DLINEAR_PROBING -o bin/classify src/classify.o src/reports.o src/hyperloglogplus.o src/mmap_file.o src/compact_hash.o src/taxonomy.o src/seqreader.o src/mmscanner.o src/omp_hack.o src/aa_translate.o src/utilities.o && codesign -s - -f bin/classify";
    const res = try sandbox.exec(alloc, io, link_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const run_cmd = "rm -f out_classify.txt && ./bin/classify -H test_db/hash.k2d -t test_db/taxo.k2d -o test_db/opts.k2d test_data/test_reads.fa > out_classify.txt 2>/dev/null";
    const res = try sandbox.exec(alloc, io, run_cmd, worker_dir, 15, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const verify_cmd = 
        \\awk '
        \\$1 == "C" && $3 == 2697049 { c1++ }
        \\$1 == "C" && $3 == 11676   { c2++ }
        \\$1 == "C" && $3 == 10710   { c3++ }
        \\END {
        \\  if (c1 == 1 && c2 == 1 && c3 == 1) exit 0;
        \\  exit 1;
        \\}' out_classify.txt
    ;
    const vres = try sandbox.exec(alloc, io, verify_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (vres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "kraken2",
    .source_root = "external/kraken2",
    .lang = .cpp,
    .source_dirs = &.{
        "src/taxonomy.cc",
        "src/mmscanner.cc",
        "src/classify.cc",
        "src/reports.cc",
        "src/aa_translate.cc",
        "src/seqreader.cc",
    },
    .skip_dirs = &.{ "data", "docs", "scripts" },
    .extensions = &.{ ".cc", ".cpp", ".c" },
    .max_workers = 2,
    .baseline_build_cmd = "./install_kraken2.sh bin",
    .build_timeout_s = 600,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
