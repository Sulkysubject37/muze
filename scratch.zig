const std = @import("std");
const sb = @import("src/sandbox_safe.zig");

pub fn main() void {
    const count_table = [_]u32{ 0, 1, 2, 3 };
    const occ_table = [_]u32{0} ** 16;
    var sp: u32 = 0;
    var ep: u32 = 0;
    sb.bwt_backward_search("ACGT", &count_table, &occ_table, 4, &sp, &ep);
    std.debug.print("1: sp={d}, ep={d}\n", .{sp, ep});

    const result2 = sb.sliding_window_minimizer("ACGTAACCGGTT", 4, 8);
    std.debug.print("2: {d}\n", .{result2});

    const tree = [_]sb.TreeNode{
        .{ .parent = 0, .depth = 0 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 1, .depth = 2 },
        .{ .parent = 1, .depth = 2 },
    };
    std.debug.print("3: {d}\n", .{sb.get_lca(3, 4, &tree)});

    const px = [_]f64{ 0.0, 1.2 };
    const py = [_]f64{ 0.0, 0.0 };
    const pz = [_]f64{ 0.0, 0.0 };
    std.debug.print("4: {d}\n", .{sb.lennard_jones_potential(&px, &py, &pz, 10.0, 2.0)});

    const seq = "ACGT";
    const kmer = sb.encode_kmer(seq, 4);
    std.debug.print("5: {d}\n", .{sb.get_canonical_kmer(kmer, 4)});
}
