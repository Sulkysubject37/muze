const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const Adapter = @import("../runner/adapter.zig").Adapter;

fn compileCmdFor(alloc: std.mem.Allocator, file: []const u8) []const u8 {
    const obj_target = std.fmt.allocPrint(alloc, "{s}o", .{file[0 .. file.len - 1]}) catch unreachable;
    defer alloc.free(obj_target);
    return std.fmt.allocPrint(alloc, "make CC=\"ccache gcc\" {s} CFLAGS=\"-O3\"", .{obj_target}) catch unreachable;
}

fn objPathFor(alloc: std.mem.Allocator, file: []const u8) []const u8 {
    return std.fmt.allocPrint(alloc, "{s}o", .{file[0 .. file.len - 1]}) catch unreachable;
}

pub const adapter = Adapter{
    .name = "samtools",
    .source_root = "external/samtools",
    .lang = .c,
    .extensions = &.{ ".c" },
    .source_dirs = &.{ 
        "sam_view.c", "bam_md.c", "bam_sort.c", "bam_index.c", 
        "bam_plcmd.c", "faidx.c", "bam_aux.c", "bam.c", 
        "sam_opts.c", "sam_utils.c", "bam_import.c", "bedidx.c", 
        "bam_rmdup.c", "bam_reheader.c", "bam_stat.c" 
    },
    .skip_dirs = &.{ "test", "tests" },
    .baseline_build_cmd = "make CC=\"ccache gcc\" CFLAGS=\"-O3\" -j4 samtools",
    .compile_db = null,
    .compile_cmd_for = compileCmdFor,
    .obj_path_for = objPathFor,
    .link_cmd = "make CC=\"ccache gcc\" CFLAGS=\"-O3\" -j4 samtools",
    .test_cmd = "make test",
    .build_timeout_s = 600,
    .test_timeout_s = 900,
    .smoke_cmd = "./samtools --version",
};
