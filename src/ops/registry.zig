const std = @import("std");
const IR = @import("../ir/soa.zig").IR;
const NIL = @import("../ir/soa.zig").NIL;
const Lang = @import("../ir/kinds.zig").Lang;
const Operator = @import("spec.zig").Operator;
const Class = @import("spec.zig").Class;

fn isBinaryOp(ir: *const IR, i: u32, op_text: []const u8) bool {
    if (ir.kind[i] != .binary_op) return false;
    const op = ir.opSlice(i);
    return op.len == op_text.len and std.mem.eql(u8, op, op_text);
}

fn identText(ir: *const IR, i: u32) []const u8 {
    return ir.nodeSlice(i);
}

fn childAt(ir: *const IR, i: u32, nth: u32) u32 {
    return ir.nthChild(i, nth);
}

fn predEq(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "=="); }
fn predNeq(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "!="); }
fn predLt(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "<"); }
fn predLte(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "<="); }
fn predGt(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, ">"); }
fn predGte(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, ">="); }
fn predPlus(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "+"); }
fn predMinus(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "-"); }
fn predBitAnd(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "&"); }
fn predBitOr(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "|"); }
fn predLogAnd(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "&&"); }
fn predLogOr(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "||"); }

pub const all = [_]Operator{
    .{ .name = "AOR: == to !=", .class = .aor, .langs = &.{ .c, .cpp }, .predicate = predEq, .replacement = "!=" },
    .{ .name = "AOR: != to ==", .class = .aor, .langs = &.{ .c, .cpp }, .predicate = predNeq, .replacement = "==" },
    .{ .name = "ROR: < to <=", .class = .ror, .langs = &.{ .c, .cpp }, .predicate = predLt, .replacement = "<=" },
    .{ .name = "ROR: < to >=", .class = .ror, .langs = &.{ .c, .cpp }, .predicate = predLt, .replacement = ">=" },
    .{ .name = "ROR: <= to <", .class = .ror, .langs = &.{ .c, .cpp }, .predicate = predLte, .replacement = "<" },
    .{ .name = "ROR: > to >=", .class = .ror, .langs = &.{ .c, .cpp }, .predicate = predGt, .replacement = ">=" },
    .{ .name = "ROR: > to <=", .class = .ror, .langs = &.{ .c, .cpp }, .predicate = predGt, .replacement = "<=" },
    .{ .name = "ROR: >= to >", .class = .ror, .langs = &.{ .c, .cpp }, .predicate = predGte, .replacement = ">" },
    .{ .name = "LCR: + to -", .class = .lcr, .langs = &.{ .c, .cpp }, .predicate = predPlus, .replacement = "-" },
    .{ .name = "LCR: - to +", .class = .lcr, .langs = &.{ .c, .cpp }, .predicate = predMinus, .replacement = "+" },
    .{ .name = "BIT: & to |", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBitAnd, .replacement = "|" },
    .{ .name = "BIT: | to &", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBitOr, .replacement = "&" },
    .{ .name = "LOG: && to ||", .class = .lcr, .langs = &.{ .c, .cpp }, .predicate = predLogAnd, .replacement = "||" },
    .{ .name = "LOG: || to &&", .class = .lcr, .langs = &.{ .c, .cpp }, .predicate = predLogOr, .replacement = "&&" },
};
