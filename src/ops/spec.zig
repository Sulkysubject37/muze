// Created by Sulkysubject37
const IR = @import("../ir/soa.zig").IR;
const Lang = @import("../ir/kinds.zig").Lang;

pub const Class = enum { bio, aor, ror, lcr, bit, log };

pub const Match = struct {
    node_idx: u32,
    op_start: u32,
    op_end:   u32,
};

pub const Operator = struct {
    name: []const u8,
    class: Class,
    langs: []const Lang,

    /// Predicate over IR. Returns true if node `i` matches this operator.
    predicate: *const fn (ir: *const IR, i: u32) bool,

    /// Bytes that replace the operator token (op_start..op_end).
    replacement: []const u8,
};
