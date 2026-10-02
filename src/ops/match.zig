const std = @import("std");
const IR = @import("../ir/soa.zig").IR;
const Lang = @import("../ir/kinds.zig").Lang;
const Operator = @import("spec.zig").Operator;
pub const Match = @import("spec.zig").Match;

fn getFnDecl(ir: *const IR, node: u32) u32 {
    var curr = node;
    while (curr != 0xffff_ffff) {
        if (ir.kind[curr] == .fn_decl) return curr;
        curr = ir.parent[curr];
    }
    return 0xffff_ffff;
}

pub fn findMatches(
    allocator: std.mem.Allocator,
    ir: *const IR,
    ops: []const Operator,
) !std.ArrayList(Match) {
    var out = std.ArrayList(Match).empty;
    errdefer out.deinit(allocator);

    var seen = std.StringHashMap(void).init(allocator);
    defer {
        var it = seen.keyIterator();
        while (it.next()) |k| allocator.free(k.*);
        seen.deinit();
    }

    var i: u32 = 0;
    while (i < ir.n) : (i += 1) {
        const k = ir.kind[i];
        if (k != .binary_op and k != .unary_op and k != .identifier and k != .int_lit) continue;
        
        var start = ir.op_start[i];
        var end = ir.op_end[i];
        
        if (k == .identifier or k == .int_lit) {
            start = ir.start[i];
            end = ir.end[i];
        } else if (start == 0 and end == 0) {
            continue;
        }

        for (ops) |op| {
            if (!langAllowed(op.langs, ir.lang[i])) continue;
            if (op.predicate(ir, i)) {
                const fn_idx = getFnDecl(ir, i);
                const key = try std.fmt.allocPrint(allocator, "{d}_{s}", .{ fn_idx, op.name });
                if (!seen.contains(key)) {
                    try seen.put(key, {});
                    try out.append(allocator, .{
                        .node_idx = i,
                        .op_start = start,
                        .op_end   = end,
                    });
                    break;
                } else {
                    allocator.free(key);
                }
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
