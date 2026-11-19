const std = @import("std");
const ts = @import("../ts/runtime.zig");
const Kind = @import("kinds.zig").Kind;
const Lang = @import("kinds.zig").Lang;
const IR = @import("soa.zig").IR;
const NIL = @import("soa.zig").NIL;

pub fn lower(
    arena: *std.heap.ArenaAllocator,
    root: ts.TSNode,
    lang: Lang,
    source: []const u8,
) !IR {
    var ir = try IR.init(arena, source, 1024 * 1024);
    _ = try walk(&ir, root, lang, NIL);
    return ir;
}

fn walk(
    ir: *IR,
    node: ts.TSNode,
    lang: Lang,
    parent_idx: u32,
) !u32 {
    const name_z = ts.ts_node_type(node);
    const name = std.mem.span(name_z);
    const kind = classify(lang, name);

    const s = ts.ts_node_start_byte(node);
    const e = ts.ts_node_end_byte(node);

    const idx = try ir.append(kind, s, e, lang, parent_idx);

    if (kind == .binary_op or kind == .unary_op) {
        if (findOperatorToken(node)) |r| {
            ir.setOpRange(idx, r.start, r.end);
        }
    }

    const n = ts.ts_node_named_child_count(node);
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        const child = ts.ts_node_named_child(node, i);
        _ = try walk(ir, child, lang, idx);
    }

    return idx;
}

const OpRange = struct { start: u32, end: u32 };

fn findOperatorToken(node: ts.TSNode) ?OpRange {
    // Scan all children (named and anonymous) for the first token that
    // sits strictly between the first and last named children.
    const total = ts.ts_node_child_count(node);
    const named = ts.ts_node_named_child_count(node);
    if (named < 2) return null;

    const first_named = ts.ts_node_named_child(node, 0);
    const last_named  = ts.ts_node_named_child(node, named - 1);
    const lhs_end   = ts.ts_node_end_byte(first_named);
    const rhs_start = ts.ts_node_start_byte(last_named);

    var i: u32 = 0;
    while (i < total) : (i += 1) {
        const c = ts.ts_node_child(node, i);
        if (ts.ts_node_is_named(c)) continue;
        const cs = ts.ts_node_start_byte(c);
        const ce = ts.ts_node_end_byte(c);
        if (cs >= lhs_end and ce <= rhs_start) {
            return .{ .start = cs, .end = ce };
        }
    }
    return null;
}

fn classify(lang: Lang, name: []const u8) Kind {
    return switch (lang) {
        .c, .cpp => classifyC(name),
        .rust    => classifyRust(name),
    };
}

fn classifyC(name: []const u8) Kind {
    const eq = std.mem.eql;
    if (eq(u8, name, "binary_expression"))      return .binary_op;
    if (eq(u8, name, "unary_expression"))       return .unary_op;
    if (eq(u8, name, "if_statement"))           return .if_stmt;
    if (eq(u8, name, "while_statement"))        return .while_stmt;
    if (eq(u8, name, "for_statement"))          return .for_stmt;
    if (eq(u8, name, "return_statement"))       return .return_stmt;
    if (eq(u8, name, "function_definition"))    return .fn_decl;
    if (eq(u8, name, "identifier") or eq(u8, name, "field_identifier")) return .identifier;
    if (eq(u8, name, "number_literal"))         return .int_lit;
    if (eq(u8, name, "string_literal"))         return .string_lit;
    if (eq(u8, name, "call_expression"))        return .call;
    if (eq(u8, name, "assignment_expression"))  return .assign;
    if (eq(u8, name, "field_expression"))       return .member_access;
    if (eq(u8, name, "subscript_expression"))   return .subscript;
    if (eq(u8, name, "preproc_include"))        return .other;
    return .other;
}

fn classifyRust(name: []const u8) Kind {
    const eq = std.mem.eql;
    if (eq(u8, name, "binary_expression"))      return .binary_op;
    if (eq(u8, name, "unary_expression"))       return .unary_op;
    if (eq(u8, name, "if_expression"))          return .if_stmt;
    if (eq(u8, name, "while_expression"))       return .while_stmt;
    if (eq(u8, name, "loop_expression"))        return .while_stmt;
    if (eq(u8, name, "for_expression"))         return .for_stmt;
    if (eq(u8, name, "return_expression"))      return .return_stmt;
    if (eq(u8, name, "function_item"))          return .fn_decl;
    if (eq(u8, name, "identifier") or eq(u8, name, "field_identifier")) return .identifier;
    if (eq(u8, name, "integer_literal"))        return .int_lit;
    if (eq(u8, name, "float_literal"))          return .float_lit;
    if (eq(u8, name, "string_literal"))         return .string_lit;
    if (eq(u8, name, "call_expression"))        return .call;
    if (eq(u8, name, "assignment_expression"))  return .assign;
    if (eq(u8, name, "field_expression"))       return .member_access;
    if (eq(u8, name, "index_expression"))       return .subscript;
    if (eq(u8, name, "macro_invocation"))       return .macro_invocation;
    return .other;
}
