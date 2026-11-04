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

// IQ-TREE Evolutionary Substitution & Phylogenetic Operators
fn predBioStateFreqMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "state_freq") != null or std.mem.indexOf(u8, r_text, "state_freq") != null;
}

fn predBioStateFreqDiv(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "state_freq") != null or std.mem.indexOf(u8, r_text, "state_freq") != null;
}

fn predBioStateFreqAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "state_freq") != null or std.mem.indexOf(u8, r_text, "state_freq") != null;
}

fn predBioNumStatesMinusOne(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    if (ir.kind[r] != .int_lit or !std.mem.eql(u8, ir.nodeSlice(r), "1")) return false;
    const l_text = ir.nodeSlice(l);
    return std.mem.indexOf(u8, l_text, "num_states") != null;
}

fn predBioRateNormDiv(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const l = childAt(ir, i, 0);
    if (l == NIL) return false;
    const l_text = ir.nodeSlice(l);
    return std.mem.indexOf(u8, l_text, "total_num_subst") != null;
}

fn predBioGammaShapePlusOne(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    if (ir.kind[r] != .int_lit or !std.mem.eql(u8, ir.nodeSlice(r), "1")) return false;
    const l_text = ir.nodeSlice(l);
    return std.mem.indexOf(u8, l_text, "gamma_shape") != null;
}

fn predBioGammaShapeMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "gamma_shape") != null or std.mem.indexOf(u8, r_text, "gamma_shape") != null;
}

fn predBioPInvarSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "p_invar") != null;
}

fn predBioNCatMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "ncategory") != null or std.mem.indexOf(u8, r_text, "ncategory") != null;
}

fn predBioNCatDiv(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "ncategory") != null;
}

fn predBioTimeMulStates(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "time") != null and std.mem.indexOf(u8, r_text, "num_states") != null) or
           (std.mem.indexOf(u8, r_text, "time") != null and std.mem.indexOf(u8, l_text, "num_states") != null);
}

fn predBioGammaCategoryPlus(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "cat") != null or std.mem.indexOf(u8, r_text, "cat") != null or
           std.mem.indexOf(u8, l_text, "ncategory") != null or std.mem.indexOf(u8, r_text, "ncategory") != null;
}

fn predBioScaleFactorPlus(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "scale") != null or std.mem.indexOf(u8, r_text, "scale") != null;
}

fn predBioRatesMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "rates") != null or std.mem.indexOf(u8, r_text, "rates") != null;
}

fn predBioRatesDiv(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "rates") != null or std.mem.indexOf(u8, r_text, "rates") != null;
}

fn predBioProbSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "1.0") != null or std.mem.indexOf(u8, l_text, "1") != null) and
           (std.mem.indexOf(u8, r_text, "freq") != null or std.mem.indexOf(u8, r_text, "mu") != null or std.mem.indexOf(u8, r_text, "exp") != null or std.mem.indexOf(u8, r_text, "diagonal") != null);
}

// BWA Short-Read Alignment & BWT Operators
fn predBioBwtL2Plus(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "L2") != null or std.mem.indexOf(u8, r_text, "L2") != null or
           std.mem.indexOf(u8, l_text, "ok") != null or std.mem.indexOf(u8, r_text, "ok") != null;
}

fn predBioBwtMatchLen(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "k") != null or std.mem.indexOf(u8, l_text, "l") != null) and
           (std.mem.indexOf(u8, r_text, "1") != null);
}

fn predBioBwt2OccMinus(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "k") != null or std.mem.indexOf(u8, l_text, "tk") != null) and
           (std.mem.indexOf(u8, r_text, "1") != null);
}

fn predBioBwtCompSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "3") != null) and
           (std.mem.indexOf(u8, r_text, "q") != null or std.mem.indexOf(u8, r_text, "c") != null);
}

fn predBioBwtBaseCharGt(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "c") != null or std.mem.indexOf(u8, l_text, "q") != null) and
           (std.mem.indexOf(u8, r_text, "3") != null);
}

fn predBioChainGapSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "len") != null or std.mem.indexOf(u8, r_text, "last") != null or
           std.mem.indexOf(u8, l_text, "qbeg") != null or std.mem.indexOf(u8, l_text, "rbeg") != null;
}

fn predBioChainBandLe(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "<=")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "w") != null;
}

fn predBioChainGapLt(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "<")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "max_chain_gap") != null or std.mem.indexOf(u8, r_text, "opt->w") != null;
}

fn predBioSeedWeightSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "end") != null;
}

fn predBioKswOeDelSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "oe_del") != null or std.mem.indexOf(u8, r_text, "o_del") != null;
}

fn predBioKswOeInsSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "oe_ins") != null or std.mem.indexOf(u8, r_text, "o_ins") != null;
}

fn predBioKswEDelSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "e_del") != null;
}

fn predBioKswEInsSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "e_ins") != null;
}

fn predBioKswMatchAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "M") != null or std.mem.indexOf(u8, l_text, "H") != null) and
           (std.mem.indexOf(u8, r_text, "q[") != null or std.mem.indexOf(u8, r_text, "mat") != null);
}

fn predBioKswBandBegSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "i") != null) and (std.mem.indexOf(u8, r_text, "w") != null);
}

fn predBioKswBandEndAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "i") != null) and (std.mem.indexOf(u8, r_text, "w") != null);
}

fn predBioGapScoreMmMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "s_mm") != null or std.mem.indexOf(u8, r_text, "s_gapo") != null or std.mem.indexOf(u8, r_text, "s_gape") != null;
}

fn predBioGapShadowSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "w[") != null or std.mem.indexOf(u8, l_text, "max") != null) and
           (std.mem.indexOf(u8, r_text, "x") != null or std.mem.indexOf(u8, r_text, "j") != null);
}

fn predBioOptAMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "opt->a") != null or std.mem.indexOf(u8, r_text, "opt->a") != null;
}

fn predBioOptADiv(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "/")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "opt->a") != null or std.mem.indexOf(u8, r_text, "opt->a") != null;
}

fn predBioOptWAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "opt->w") != null or std.mem.indexOf(u8, r_text, "opt->w") != null or
           std.mem.indexOf(u8, l_text, "w2") != null or std.mem.indexOf(u8, r_text, "w2") != null;
}

fn predBioSeedLenComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">") and !isBinaryOp(ir, i, ">=") and !isBinaryOp(ir, i, "<")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "min_seed_len") != null;
}

fn predBioMaxOccComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">") and !isBinaryOp(ir, i, ">=")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "max_occ") != null;
}

fn predBioScoreTComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">") and !isBinaryOp(ir, i, ">=") and !isBinaryOp(ir, i, "<")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "opt->T") != null;
}

fn predBioZdropComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">") and !isBinaryOp(ir, i, "<") and !isBinaryOp(ir, i, ">=")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "zdrop") != null;
}

fn predBioPenClipAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "pen_clip") != null or std.mem.indexOf(u8, r_text, "pen_clip") != null;
}

fn predBioBwtPrimaryComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "<=") and !isBinaryOp(ir, i, ">=")) return false;
    const r = childAt(ir, i, 1);
    if (r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "primary") != null;
}

fn predBioKswMaxScoreComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "h") != null or std.mem.indexOf(u8, l_text, "M") != null) and
           (std.mem.indexOf(u8, r_text, "e") != null or std.mem.indexOf(u8, r_text, "f") != null);
}

fn predBioKswZeroComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "t") != null or std.mem.indexOf(u8, l_text, "h1") != null) and
           (std.mem.indexOf(u8, r_text, "0") != null);
}

fn predBioBwtTlTkSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "tl") != null and std.mem.indexOf(u8, r_text, "tk") != null;
}

fn predBioBwtCumulativeAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "ok[") != null and std.mem.indexOf(u8, r_text, "ok[") != null;
}

fn predBioChainQendAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "qbeg") != null or std.mem.indexOf(u8, l_text, "rbeg") != null) and
           (std.mem.indexOf(u8, r_text, "len") != null);
}

fn predBioChainWeightLenAdd(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "+")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "w") != null and std.mem.indexOf(u8, r_text, "s->len") != null;
}

fn predBioChainYDiffSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return (std.mem.indexOf(u8, l_text, "rbeg") != null and std.mem.indexOf(u8, r_text, "last->rbeg") != null) or
           (std.mem.indexOf(u8, l_text, "qbeg") != null and std.mem.indexOf(u8, r_text, "last->qbeg") != null);
}

fn predBioKswHfGt(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "h") != null and std.mem.indexOf(u8, r_text, "f") != null;
}

fn predBioKswGscoreGt(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "gscore") != null and std.mem.indexOf(u8, r_text, "h1") != null;
}

fn predBioGapBestGt(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "best") != null and std.mem.indexOf(u8, r_text, "score") != null;
}

fn predBioSplitFactorMul(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "*")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, r_text, "split_factor") != null;
}

fn predBioBnsLpacComp(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, ">=") and !isBinaryOp(ir, i, "<=") and !isBinaryOp(ir, i, "<") and !isBinaryOp(ir, i, ">")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "l_pac") != null or std.mem.indexOf(u8, r_text, "l_pac") != null;
}

fn predBioBnsCoordSub(ir: *const IR, i: u32) bool {
    if (!isBinaryOp(ir, i, "-")) return false;
    const l = childAt(ir, i, 0);
    const r = childAt(ir, i, 1);
    if (l == NIL or r == NIL) return false;
    const l_text = ir.nodeSlice(l);
    const r_text = ir.nodeSlice(r);
    return std.mem.indexOf(u8, l_text, "l_pac") != null or std.mem.indexOf(u8, r_text, "end") != null or std.mem.indexOf(u8, r_text, "beg") != null;
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

    // IQ-TREE Evolutionary & Phylogenetic Operators
    .{ .name = "BIO: Detailed Balance State Frequency Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioStateFreqMul, .replacement = "/" },
    .{ .name = "BIO: Detailed Balance State Frequency Divide to Multiply", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioStateFreqDiv, .replacement = "*" },
    .{ .name = "BIO: Substitution Rate Normalization Divide to Multiply", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioRateNormDiv, .replacement = "*" },
    .{ .name = "BIO: Gamma Rate Recurrence Plus One to Minus One", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioGammaShapePlusOne, .replacement = "-" },
    .{ .name = "BIO: Gamma Degrees of Freedom Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioGammaShapeMul, .replacement = "/" },
    .{ .name = "BIO: Invariable Sites Proportion Sign Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioPInvarSub, .replacement = "+" },
    .{ .name = "BIO: Discrete Category Weight Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioNCatMul, .replacement = "/" },
    .{ .name = "BIO: Discrete Category Weight Divide to Multiply", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioNCatDiv, .replacement = "*" },
    .{ .name = "BIO: Branch Time Dimensionality Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioTimeMulStates, .replacement = "/" },
    .{ .name = "BIO: Category Discretization Plus to Minus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioGammaCategoryPlus, .replacement = "-" },
    .{ .name = "BIO: Likelihood Scaling Addition to Subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioScaleFactorPlus, .replacement = "-" },
    .{ .name = "BIO: Substitution Rate Scaling Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioRatesMul, .replacement = "/" },
    .{ .name = "BIO: Substitution Rate Scaling Divide to Multiply", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioRatesDiv, .replacement = "*" },
    .{ .name = "BIO: Transition Probability Conservation Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioProbSub, .replacement = "+" },
    .{ .name = "BIO: State Frequency Summation Addition to Subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioStateFreqAdd, .replacement = "-" },
    .{ .name = "BIO: State Dimension Degrees of Freedom Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioNumStatesMinusOne, .replacement = "+" },
    .{ .name = "BIO: State Frequency Equal to Estimate", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("FREQ_EQUAL"), .replacement = "FREQ_ESTIMATE" },
    .{ .name = "BIO: State Frequency Estimate to Equal", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("FREQ_ESTIMATE"), .replacement = "FREQ_EQUAL" },
    .{ .name = "BIO: State Frequency Empirical to Equal", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("FREQ_EMPIRICAL"), .replacement = "FREQ_EQUAL" },
    .{ .name = "BIO: Sequence Alphabet DNA to Protein", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("SEQ_DNA"), .replacement = "SEQ_PROTEIN" },
    .{ .name = "BIO: Invariable Sites Bound Tolerance Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("MIN_PINVAR"), .replacement = "TOL_PINVAR" },
    .{ .name = "BIO: Zero Frequency Threshold Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("ZERO_FREQ"), .replacement = "MIN_RATE" },

    // BWA Short-Read Alignment & BWT Operators
    .{ .name = "BIO: FM-Index Interval Lower Bound Plus to Minus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtL2Plus, .replacement = "-" },
    .{ .name = "BIO: BWT Suffix Match Length Plus to Minus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtMatchLen, .replacement = "-" },
    .{ .name = "BIO: BWT 2Occ Interval Query Rank Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwt2OccMinus, .replacement = "+" },
    .{ .name = "BIO: BWT Complement Base Calculation Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtCompSub, .replacement = "+" },
    .{ .name = "BIO: BWT Base Character Alphabet Bound Greater to GreaterEqual", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtBaseCharGt, .replacement = ">=" },
    .{ .name = "BIO: BWA-MEM Chaining Distance Gap Subtraction to Addition", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioChainGapSub, .replacement = "+" },
    .{ .name = "BIO: BWA-MEM Chaining Band Width LessEqual to GreaterEqual", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioChainBandLe, .replacement = ">=" },
    .{ .name = "BIO: BWA-MEM Chaining Max Gap LessThan to GreaterThan", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioChainGapLt, .replacement = ">" },
    .{ .name = "BIO: BWA-MEM Seed Weight Overlap Deduction Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioSeedWeightSub, .replacement = "+" },
    .{ .name = "BIO: KSW Deletion Open+Extend Deduction Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswOeDelSub, .replacement = "+" },
    .{ .name = "BIO: KSW Insertion Open+Extend Deduction Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswOeInsSub, .replacement = "+" },
    .{ .name = "BIO: KSW Deletion Extension Cost Deduction Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswEDelSub, .replacement = "+" },
    .{ .name = "BIO: KSW Insertion Extension Cost Deduction Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswEInsSub, .replacement = "+" },
    .{ .name = "BIO: KSW Dynamic Programming Match Addition to Subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswMatchAdd, .replacement = "-" },
    .{ .name = "BIO: KSW Band Left Clamping Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswBandBegSub, .replacement = "+" },
    .{ .name = "BIO: KSW Band Right Clamping Plus to Minus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswBandEndAdd, .replacement = "-" },
    .{ .name = "BIO: BWT-GAP Alignment Mismatch Score Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioGapScoreMmMul, .replacement = "/" },
    .{ .name = "BIO: BWT-GAP Shadow Width Subtraction to Addition", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioGapShadowSub, .replacement = "+" },
    .{ .name = "BIO: BWA Deletion to Insertion Open Cost Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("o_del"), .replacement = "o_ins" },
    .{ .name = "BIO: BWA Insertion to Deletion Open Cost Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("o_ins"), .replacement = "o_del" },
    .{ .name = "BIO: BWA Deletion to Insertion Extension Cost Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("e_del"), .replacement = "e_ins" },
    .{ .name = "BIO: BWA Insertion to Deletion Extension Cost Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("e_ins"), .replacement = "e_del" },
    .{ .name = "BIO: BWA Match Score Scaling Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioOptAMul, .replacement = "/" },
    .{ .name = "BIO: BWA Match Score Scaling Divide to Multiply", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioOptADiv, .replacement = "*" },
    .{ .name = "BIO: BWA Band Width Addition to Subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioOptWAdd, .replacement = "-" },
    .{ .name = "BIO: BWA Minimum Seed Length Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioSeedLenComp, .replacement = "<" },
    .{ .name = "BIO: BWA Maximum Occurrence Filter Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioMaxOccComp, .replacement = "<" },
    .{ .name = "BIO: BWA Score Threshold Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioScoreTComp, .replacement = "<" },
    .{ .name = "BIO: BWA Z-drop Extension Check Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioZdropComp, .replacement = "<" },
    .{ .name = "BIO: BWA Clipping Penalty Addition to Subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioPenClipAdd, .replacement = "-" },
    .{ .name = "BIO: BWT Primary Index Comparison Bound Inversion", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtPrimaryComp, .replacement = ">" },
    .{ .name = "BIO: KSW Score Maximum Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswMaxScoreComp, .replacement = "<" },
    .{ .name = "BIO: KSW Score Floor Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswZeroComp, .replacement = "<" },
    .{ .name = "BIO: BWA Seed Length Identifier to Split Width", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("min_seed_len"), .replacement = "split_width" },
    .{ .name = "BIO: BWA Max Chain Gap Identifier to Max Ins", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("max_chain_gap"), .replacement = "max_ins" },
    .{ .name = "BIO: BWA Clip 5-prime to 3-prime Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("pen_clip5"), .replacement = "pen_clip3" },
    .{ .name = "BIO: BWA Clip 3-prime to 5-prime Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("pen_clip3"), .replacement = "pen_clip5" },
    .{ .name = "BIO: BWT-GAP State Insertion to Deletion", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("STATE_I"), .replacement = "STATE_D" },
    .{ .name = "BIO: BWT-GAP State Deletion to Insertion", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("STATE_D"), .replacement = "STATE_I" },
    .{ .name = "BIO: BWT-GAP State Match to Insertion", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("STATE_M"), .replacement = "STATE_I" },
    .{ .name = "BIO: BWT Interval Width Difference Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtTlTkSub, .replacement = "+" },
    .{ .name = "BIO: BWT Forward Interval Cumulative Add to Sub", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBwtCumulativeAdd, .replacement = "-" },
    .{ .name = "BIO: BWA-MEM Seed Coordinate Range Plus to Minus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioChainQendAdd, .replacement = "-" },
    .{ .name = "BIO: BWA-MEM Chain Weight Length Addition to Subtraction", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioChainWeightLenAdd, .replacement = "-" },
    .{ .name = "BIO: BWA-MEM Seed Distance Difference Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioChainYDiffSub, .replacement = "+" },
    .{ .name = "BIO: KSW Score F-matrix Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswHfGt, .replacement = "<" },
    .{ .name = "BIO: KSW Global Score Max Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioKswGscoreGt, .replacement = "<" },
    .{ .name = "BIO: BWT-GAP Stack Best Score Comparison Greater to Less", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioGapBestGt, .replacement = "<" },
    .{ .name = "BIO: BWA Mismatch Penalty Identifier to Match Score", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("opt->b"), .replacement = "opt->a" },
    .{ .name = "BIO: BWA Band Width Identifier to Z-drop", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("opt->w"), .replacement = "opt->zdrop" },
    .{ .name = "BIO: BWA Z-drop Identifier to Band Width", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("opt->zdrop"), .replacement = "opt->w" },
    .{ .name = "BIO: BWA Max Matesw Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("max_matesw"), .replacement = "max_occ" },
    .{ .name = "BIO: BWA Mask Level Identifier to Redundant Mask Level", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("mask_level"), .replacement = "mask_level_redun" },
    .{ .name = "BIO: BWA Secondary Drop Ratio Identifier to XA Drop Ratio", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("drop_ratio"), .replacement = "XA_drop_ratio" },
    .{ .name = "BIO: BWA Max MEM Interval Identifier to Split Width", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("max_mem_intv"), .replacement = "split_width" },
    .{ .name = "BIO: BWA Pen Unpaired Identifier to Pen Clip5", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("pen_unpaired"), .replacement = "pen_clip5" },
    .{ .name = "BIO: BWA Split Factor Scaling Multiply to Divide", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioSplitFactorMul, .replacement = "/" },
    .{ .name = "BIO: BNS Reference Coordinate pac Comparison Bound Inversion", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBnsLpacComp, .replacement = "==" },
    .{ .name = "BIO: BNS Reverse Strand Coordinate Offset Minus to Plus", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = predBioBnsCoordSub, .replacement = "+" },
    .{ .name = "BIO: BWA Alignment Score Flag Tag Swap", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("NM"), .replacement = "AS" },
    .{ .name = "BIO: BWA CIGAR Length Shift", .class = .bio, .langs = &.{ .c, .cpp }, .predicate = makeIdentPred("n_cigar"), .replacement = "n_cigar_" },
};
