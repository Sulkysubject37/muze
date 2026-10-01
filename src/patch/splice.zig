const std = @import("std");
const Match = @import("../ops/spec.zig").Match;

pub fn splice(
    allocator: std.mem.Allocator,
    source: []const u8,
    m: Match,
    replacement: []const u8,
) ![]u8 {
    var out = std.ArrayList(u8).empty;
    errdefer out.deinit(allocator);

    try out.appendSlice(allocator, source[0..m.op_start]);
    try out.appendSlice(allocator, replacement);
    try out.appendSlice(allocator, source[m.op_end..]);

    return out.toOwnedSlice(allocator);
}
