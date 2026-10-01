const std = @import("std");
const IR = @import("../ir/soa.zig").IR;
const Lang = @import("../ir/kinds.zig").Lang;
const Operator = @import("spec.zig").Operator;
pub const Match = @import("spec.zig").Match;

pub fn findMatches(
    allocator: std.mem.Allocator,
    ir: *const IR,
    ops: []const Operator,
) !std.ArrayList(Match) {
    var out = std.ArrayList(Match).empty;
    errdefer out.deinit(allocator);

    var i: u32 = 0;
    while (i < ir.n) : (i += 1) {
        const k = ir.kind[i];
        if (k != .binary_op and k != .unary_op) continue;
        if (ir.op_start[i] == 0 and ir.op_end[i] == 0) continue;

        for (ops) |op| {
            if (!langAllowed(op.langs, ir.lang[i])) continue;
            if (op.predicate(ir, i)) {
                try out.append(allocator, .{
                    .node_idx = i,
                    .op_start = ir.op_start[i],
                    .op_end   = ir.op_end[i],
                });
                break; // one operator per node
            }
        }
    }

    std.mem.sort(Match, out.items, {}, lessByStart);
    return out;
}

fn langAllowed(langs: []const Lang, l: Lang) bool {
    for (langs) |x| if (x == l) return true;
    return false;
}

fn lessByStart(_: void, a: Match, b: Match) bool {
    return a.op_start < b.op_start;
}

/// Reject overlapping matches: keep the earliest, drop any that
/// start before the previous match's end.
pub fn dedupeOverlaps(
    allocator: std.mem.Allocator,
    in: std.ArrayList(Match)
) !std.ArrayList(Match) {
    var out = std.ArrayList(Match).empty;
    errdefer out.deinit(allocator);

    var last_end: u32 = 0;
    for (in.items) |m| {
        if (m.op_start >= last_end) {
            try out.append(allocator, m);
            last_end = m.op_end;
        }
    }
    return out;
}
