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
    _ = sandbox.exec(alloc, io, "ccache -z", worker_dir, 10, "/dev/null", "/dev/null") catch {};
    
    const obj_file = try std.fmt.allocPrint(alloc, "{s}o", .{file_path[0 .. file_path.len - 1]});
    defer alloc.free(obj_file);

    const rm_cmd = try std.fmt.allocPrint(alloc, "rm -f {s}", .{obj_file});
    defer alloc.free(rm_cmd);
    _ = sandbox.exec(alloc, io, rm_cmd, worker_dir, 10, "/dev/null", "/dev/null") catch {};

    const compile_cmd = try std.fmt.allocPrint(alloc, "gcc -c -g -Wall -Wno-unused-function -O3 -DHAVE_PTHREAD -DUSE_MALLOC_WRAPPERS -ffile-prefix-map={s}=. {s} -o {s}", .{ worker_dir, file_path, obj_file });
    defer alloc.free(compile_cmd);

    const res = try sandbox.exec(alloc, io, compile_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;

    const ar_cmd = try std.fmt.allocPrint(alloc, "ar -csru libbwa.a {s}", .{obj_file});
    defer alloc.free(ar_cmd);
    _ = sandbox.exec(alloc, io, ar_cmd, worker_dir, 30, "/dev/null", "/dev/null") catch {};

    return std.fmt.allocPrint(alloc, "{s}/{s}", .{ worker_dir, obj_file });
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const link_cmd = "gcc -g -Wall -Wno-unused-function -O3 bwashm.o bwase.o bwaseqio.o bwtgap.o bwtaln.o bamlite.o bwape.o kopen.o pemerge.o maxk.o bwtsw2_core.o bwtsw2_main.o bwtsw2_aux.o bwt_lite.o bwtsw2_chain.o fastmap.o bwtsw2_pair.o main.o -o bwa -L. -lbwa -lm -lz -lpthread";
    const res = try sandbox.exec(alloc, io, link_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const run_cmd = "rm -f out_test.sam && ./bwa mem test_data/ref.fa test_data/reads.fq > out_test.sam 2>/dev/null";
    const res = try sandbox.exec(alloc, io, run_cmd, worker_dir, 15, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const verify_cmd = 
        \\awk 'BEGIN { mapped = 0; fail = 0; }
        \\/^@/ { next }
        \\{
        \\    flag = $2; pos = $4; mapq = $5; cigar = $6;
        \\    if (int(flag / 4) % 2 == 1) { fail = 1; exit 1; }
        \\    if (pos <= 0 || mapq < 10) { fail = 1; exit 1; }
        \\    if (cigar !~ /^[0-9]+M$/) { fail = 1; exit 1; }
        \\    mapped++;
        \\}
        \\END {
        \\    if (fail || mapped != 20) exit 1;
        \\    exit 0;
        \\}' out_test.sam
    ;
    const vres = try sandbox.exec(alloc, io, verify_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (vres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "bwa",
    .source_root = "external/bwa",
    .lang = .c,
    .source_dirs = &.{ "bwt.c", "bwamem.c", "ksw.c", "bwtgap.c", "bwamem_pair.c", "bwamem_extra.c", "bntseq.c" },
    .skip_dirs = &.{},
    .extensions = &.{ ".c" },
    .max_workers = 2,
    .baseline_build_cmd = "make -j4",
    .build_timeout_s = 300,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
