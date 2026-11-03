const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const ToolAdapter = @import("../runner/adapter.zig").ToolAdapter;
const classify = @import("../runner/classify.zig");
const sandbox = @import("../runner/sandbox.zig");

fn initWorker(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8, baseline_dir: []const u8) anyerror!void {
    try sandbox.copyTree(alloc, io, baseline_dir, worker_dir);
}

fn compileMutant(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8, worker_dir: []const u8) anyerror![]const u8 {
    _ = sandbox.exec(alloc, io, "ccache -z", worker_dir, 10, "/dev/null", "/dev/null") catch {};
    
    const obj_target = try std.fmt.allocPrint(alloc, "{s}o", .{file_path[0 .. file_path.len - 1]});
    defer alloc.free(obj_target);
    
    const mut_rm_cmd = try std.fmt.allocPrint(alloc, "rm -f {s}", .{obj_target});
    _ = sandbox.exec(alloc, io, mut_rm_cmd, worker_dir, 10, "/dev/null", "/dev/null") catch {};
    alloc.free(mut_rm_cmd);

    const cmd = try std.fmt.allocPrint(alloc, "make CC=\"ccache gcc\" {s} CFLAGS=\"-O3 -ffile-prefix-map={s}=.\"", .{obj_target, worker_dir});
    defer alloc.free(cmd);
    
    const res = try sandbox.exec(alloc, io, cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;
    
    
    
    
    return std.fmt.allocPrint(alloc, "{s}/{s}", .{worker_dir, obj_target});
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const res = try sandbox.exec(alloc, io, "make CC=\"ccache gcc\" CFLAGS=\"-O3\" -j1 samtools", worker_dir, 60, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const res = try sandbox.exec(alloc, io, "make test -j1", worker_dir, 900, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;
    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "samtools",
    .source_root = "external/samtools",
    .lang = .c,
    .source_dirs = &.{ 
        "sam_view.c", "bam_md.c", "bam_sort.c", "bam_index.c", 
        "bam_plcmd.c", "faidx.c", "bam_aux.c", "bam.c", 
        "sam_opts.c", "sam_utils.c", "bam_import.c", "bedidx.c", 
        "bam_rmdup.c", "bam_reheader.c", "bam_stat.c" 
    },
    .skip_dirs = &.{ "test", "tests" },
    .extensions = &.{ ".c" },
    .max_workers = 2,
    .baseline_build_cmd = "make CC=\"ccache gcc\" CFLAGS=\"-O3\" -j8 samtools",
    .build_timeout_s = 600,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
