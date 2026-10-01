pub const Kind = enum(u8) {
    fn_decl,
    binary_op,
    unary_op,
    if_stmt,
    while_stmt,
    for_stmt,
    return_stmt,
    identifier,
    int_lit,
    float_lit,
    string_lit,
    call,
    assign,
    member_access,
    subscript,
    macro_invocation,
    other,
};

pub const Lang = enum(u8) {
    c,
    cpp,
    rust,

    pub fn fromExtension(ext: []const u8) ?Lang {
        if (std.mem.eql(u8, ext, ".c") or std.mem.eql(u8, ext, ".h")) return .c;
        if (std.mem.eql(u8, ext, ".cpp") or std.mem.eql(u8, ext, ".hpp")
            or std.mem.eql(u8, ext, ".cc") or std.mem.eql(u8, ext, ".cxx")) return .cpp;
        if (std.mem.eql(u8, ext, ".rs")) return .rust;
        return null;
    }
};

const std = @import("std");
