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

fn identText(ir: *const IR, i: u32) []const u8 { return ir.nodeSlice(i); }
fn childAt(ir: *const IR, i: u32, nth: u32) u32 { return ir.nthChild(i, nth); }

fn predEq(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "=="); }
fn predNeq(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "!="); }
fn predPlus(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "+"); }
fn predMinus(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "-"); }
fn predBitAnd(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "&"); }
fn predBitOr(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "|"); }
fn predLogAnd(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "&&"); }
fn predLogOr(ir: *const IR, i: u32) bool { return isBinaryOp(ir, i, "||"); }

fn makeIdentPred(comptime name: []const u8) fn (ir: *const IR, i: u32) bool {
    const P = struct {
        fn p(ir: *const IR, i: u32) bool {
            return ir.kind[i] == .identifier and std.mem.eql(u8, identText(ir, i), name);
        }
    };
    return P.p;
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

fn predBioLeapfrogSign(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL or ir.kind[r] != .binary_op) return false;
    if (!std.mem.eql(u8, ir.opSlice(r), "*")) return false;
    const rr = childAt(ir, r, 1);
    if (rr != NIL and ir.kind[rr] == .identifier and std.mem.eql(u8, identText(ir, rr), "dt")) return true;
    const rl = childAt(ir, r, 0);
    if (rl != NIL and ir.kind[rl] == .identifier and std.mem.eql(u8, identText(ir, rl), "dt")) return true;
    return false;
}

fn predBioVRescale(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    if (ir.kind[l] != .identifier or ir.kind[r] != .identifier) return false;
    return std.mem.eql(u8, identText(ir, l), "Ek_new") and std.mem.eql(u8, identText(ir, r), "Ek");
}

fn predBioDtMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const r = childAt(ir, i, 1);
    if (r != NIL and ir.kind[r] == .identifier and std.mem.eql(u8, identText(ir, r), "dt")) return true;
    const l = childAt(ir, i, 0);
    if (l != NIL and ir.kind[l] == .identifier and std.mem.eql(u8, identText(ir, l), "dt")) return true;
    return false;
}

fn predBioDtDiv(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const r = childAt(ir, i, 1);
    if (r != NIL and ir.kind[r] == .identifier and std.mem.eql(u8, identText(ir, r), "dt")) return true;
    return false;
}

pub const all = [_]Operator{

    .{ .name = "AOR: != to ==", .class = .aor, .langs = &.{ .c, .cpp }, .predicate = predNeq, .replacement = "==" },
    .{ .name = "LCR: + to -", .class = .lcr, .langs = &.{ .c, .cpp }, .predicate = predPlus, .replacement = "-" },
    .{ .name = "LCR: - to +", .class = .lcr, .langs = &.{ .c, .cpp }, .predicate = predMinus, .replacement = "+" },
    .{ .name = "BIT: & to |", .class = .bit, .langs = &.{ .c, .cpp }, .predicate = predBitAnd, .replacement = "|" },
    .{ .name = "BIT: | to &", .class = .bit, .langs = &.{ .c, .cpp }, .predicate = predBitOr, .replacement = "&" },
    .{ .name = "LOG: && to ||", .class = .log, .langs = &.{ .c, .cpp }, .predicate = predLogAnd, .replacement = "||" },
    .{ .name = "LOG: || to &&", .class = .log, .langs = &.{ .c, .cpp }, .predicate = predLogOr, .replacement = "&&" },
    
    .{ .name = "BIO: BAM_FPAIRED to BAM_FREVERSE", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPAIRED"), .replacement = "BAM_FREVERSE" },
    .{ .name = "BIO: BAM_FPAIRED to BAM_FPROPER_PAIR", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPAIRED"), .replacement = "BAM_FPROPER_PAIR" },
    .{ .name = "BIO: BAM_FPAIRED to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPAIRED"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FREVERSE to BAM_FPAIRED", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREVERSE"), .replacement = "BAM_FPAIRED" },
    .{ .name = "BIO: BAM_FREVERSE to BAM_FMREVERSE", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREVERSE"), .replacement = "BAM_FMREVERSE" },
    .{ .name = "BIO: BAM_FREVERSE to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREVERSE"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FPROPER_PAIR to BAM_FPAIRED", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPROPER_PAIR"), .replacement = "BAM_FPAIRED" },
    .{ .name = "BIO: BAM_FPROPER_PAIR to BAM_FREVERSE", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPROPER_PAIR"), .replacement = "BAM_FREVERSE" },
    .{ .name = "BIO: BAM_FUNMAP to BAM_FMUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FUNMAP"), .replacement = "BAM_FMUNMAP" },
    .{ .name = "BIO: BAM_FUNMAP to BAM_FPAIRED", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FUNMAP"), .replacement = "BAM_FPAIRED" },
    .{ .name = "BIO: BAM_FMUNMAP to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FMUNMAP"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FREAD1 to BAM_FREAD2", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREAD1"), .replacement = "BAM_FREAD2" },
    .{ .name = "BIO: BAM_FREAD2 to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREAD2"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FSECONDARY to BAM_FSUPPLEMENTARY", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FSECONDARY"), .replacement = "BAM_FSUPPLEMENTARY" },
    .{ .name = "BIO: BAM_FSECONDARY to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FSECONDARY"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FSUPPLEMENTARY to BAM_FSECONDARY", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FSUPPLEMENTARY"), .replacement = "BAM_FSECONDARY" },
    .{ .name = "BIO: BAM_FSUPPLEMENTARY to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FSUPPLEMENTARY"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FQCFAIL to BAM_FDUP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FQCFAIL"), .replacement = "BAM_FDUP" },
    .{ .name = "BIO: BAM_FDUP to BAM_FQCFAIL", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FDUP"), .replacement = "BAM_FQCFAIL" },

    .{ .name = "BIO: bam_cigar_oplen to bam_cigar_op", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("bam_cigar_oplen"), .replacement = "bam_cigar_op" },
    .{ .name = "BIO: bam_cigar_op to bam_cigar_oplen", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("bam_cigar_op"), .replacement = "bam_cigar_oplen" },
    .{ .name = "BIO: BAM_CMATCH to BAM_CINS", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CMATCH"), .replacement = "BAM_CINS" },
    .{ .name = "BIO: BAM_CMATCH to BAM_CDEL", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CMATCH"), .replacement = "BAM_CDEL" },
    .{ .name = "BIO: BAM_CMATCH to BAM_CREF_SKIP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CMATCH"), .replacement = "BAM_CREF_SKIP" },
    .{ .name = "BIO: BAM_CINS to BAM_CMATCH", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CINS"), .replacement = "BAM_CMATCH" },
    .{ .name = "BIO: BAM_CDEL to BAM_CMATCH", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CDEL"), .replacement = "BAM_CMATCH" },
    .{ .name = "BIO: BAM_CREF_SKIP to BAM_CMATCH", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CREF_SKIP"), .replacement = "BAM_CMATCH" },
    .{ .name = "BIO: BAM_CSOFT_CLIP to BAM_CHARD_CLIP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CSOFT_CLIP"), .replacement = "BAM_CHARD_CLIP" },
    .{ .name = "BIO: BAM_CHARD_CLIP to BAM_CSOFT_CLIP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CHARD_CLIP"), .replacement = "BAM_CSOFT_CLIP" },
    .{ .name = "BIO: BAM_CEQUAL to BAM_CDIFF", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CEQUAL"), .replacement = "BAM_CDIFF" },
    .{ .name = "BIO: BAM_CDIFF to BAM_CEQUAL", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_CDIFF"), .replacement = "BAM_CEQUAL" },
    .{ .name = "BIO: bam_is_rev to bam_is_mrev", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("bam_is_rev"), .replacement = "bam_is_mrev" },
    .{ .name = "BIO: bam_is_mrev to bam_is_rev", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("bam_is_mrev"), .replacement = "bam_is_rev" },
    
    .{ .name = "BIO: BAM_FPAIRED to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPAIRED"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FPAIRED to BAM_FREAD2", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPAIRED"), .replacement = "BAM_FREAD2" },
    .{ .name = "BIO: BAM_FPAIRED to BAM_FSECONDARY", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPAIRED"), .replacement = "BAM_FSECONDARY" },
    .{ .name = "BIO: BAM_FPROPER_PAIR to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPROPER_PAIR"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FPROPER_PAIR to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FPROPER_PAIR"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FREVERSE to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREVERSE"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FREVERSE to BAM_FSECONDARY", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREVERSE"), .replacement = "BAM_FSECONDARY" },
    .{ .name = "BIO: BAM_FMREVERSE to BAM_FREAD2", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FMREVERSE"), .replacement = "BAM_FREAD2" },
    .{ .name = "BIO: BAM_FMUNMAP to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FMUNMAP"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FREAD1 to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREAD1"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FREAD2 to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FREAD2"), .replacement = "BAM_FUNMAP" },
    .{ .name = "BIO: BAM_FSECONDARY to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FSECONDARY"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FQCFAIL to BAM_FREAD1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FQCFAIL"), .replacement = "BAM_FREAD1" },
    .{ .name = "BIO: BAM_FDUP to BAM_FUNMAP", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("BAM_FDUP"), .replacement = "BAM_FUNMAP" },

    .{ .name = "BIO: pos + 1 to pos - 1", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioPosPlusOne, .replacement = "-" },
    .{ .name = "BIO: overlap < end to <= end", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioOverlapLt, .replacement = "<=" },
    // GROMACS Molecular Dynamics & Water Physics Operators
    .{ .name = "BIO: Leapfrog dt addition to subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioLeapfrogSign, .replacement = "-" },
    .{ .name = "BIO: MD Timestep dt Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioDtMul, .replacement = "/" },
    .{ .name = "BIO: MD Timestep dt Divide to Multiply", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioDtDiv, .replacement = "*" },
    .{ .name = "BIO: V-rescale Ratio Fault (divide to multiply)", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioVRescale, .replacement = "*" },
    .{ .name = "BIO: PBC std::floor to std::ceil", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("std::floor"), .replacement = "std::ceil" },
    .{ .name = "BIO: PBC floor to ceil", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("floor"), .replacement = "ceil" },
    .{ .name = "BIO: PBC ceil to floor", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("ceil"), .replacement = "floor" },
    .{ .name = "BIO: Settle Water O-H to H-H distance", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("dOH"), .replacement = "dHH" },
    .{ .name = "BIO: Settle Water H-H to O-H distance", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("dHH"), .replacement = "dOH" },
    .{ .name = "BIO: Settle Water Oxygen to Hydrogen Mass", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("mO"), .replacement = "mH" },
    .{ .name = "BIO: Settle Water Hydrogen to Oxygen Mass", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("mH"), .replacement = "mO" },
    .{ .name = "BIO: Settle Water Inverse Oxygen to Hydrogen Mass", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("imO"), .replacement = "imH" },
    .{ .name = "BIO: Settle Water Inverse Hydrogen to Oxygen Mass", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("imH"), .replacement = "imO" },
    .{ .name = "BIO: Settle Water Inverse O-H to H-H distance", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("invdOH"), .replacement = "invdHH" },
    .{ .name = "BIO: Settle Water Inverse H-H to O-H distance", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("invdHH"), .replacement = "invdOH" },
    .{ .name = "BIO: Forcefield fudgeQQ to fudgeLJ", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("fudgeQQ"), .replacement = "fudgeLJ" },
    .{ .name = "BIO: Forcefield fudgeLJ to fudgeQQ", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("fudgeLJ"), .replacement = "fudgeQQ" },
};
