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

// REAL BIO OPERATORS
fn predBamFReverse(ir: *const IR, i: u32) bool {
    return ir.kind[i] == .identifier and std.mem.eql(u8, identText(ir, i), "BAM_FREVERSE");
}
fn predBamFPaired(ir: *const IR, i: u32) bool {
    return ir.kind[i] == .identifier and std.mem.eql(u8, identText(ir, i), "BAM_FPAIRED");
}
fn predCigarOpLen(ir: *const IR, i: u32) bool {
    // Actually bam_cigar_oplen is a macro call or identifier
    return ir.kind[i] == .identifier and std.mem.eql(u8, identText(ir, i), "bam_cigar_oplen");
}
fn predBioPosPlusOne(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    if (ir.kind[r] != .int_lit or !std.mem.eql(u8, ir.nodeSlice(r), "1")) return false;
    const l_text = ir.nodeSlice(l);
    return std.mem.indexOf(u8, l_text, "pos") != null;
}
fn predBioOverlapLt(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "<")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    const l_text = ir.nodeSlice(l);
    return std.mem.indexOf(u8, r_text, "end") != null or std.mem.indexOf(u8, l_text, "end") != null;
}

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
    .{ .name = "BIT: & to |", .class = .bit, .langs = &.{ .c, .cpp }, .predicate = predBitAnd, .replacement = "|" },
    .{ .name = "BIT: | to &", .class = .bit, .langs = &.{ .c, .cpp }, .predicate = predBitOr, .replacement = "&" },
    .{ .name = "LOG: && to ||", .class = .log, .langs = &.{ .c, .cpp }, .predicate = predLogAnd, .replacement = "||" },
    .{ .name = "LOG: || to &&", .class = .log, .langs = &.{ .c, .cpp }, .predicate = predLogOr, .replacement = "&&" },
    
    // Bio operators
    .{ .name = "BIO: BAM_FREVERSE to BAM_FPAIRED", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBamFReverse, .replacement = "BAM_FPAIRED" },
    .{ .name = "BIO: BAM_FPAIRED to BAM_FREVERSE", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBamFPaired, .replacement = "BAM_FREVERSE" },
    .{ .name = "BIO: bam_cigar_oplen to bam_cigar_op", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predCigarOpLen, .replacement = "bam_cigar_op" },
    .{ .name = "BIO: pos + 1 to pos - 1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioPosPlusOne, .replacement = "-" },
    .{ .name = "BIO: overlap < end to <= end", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioOverlapLt, .replacement = "<=" },
};
