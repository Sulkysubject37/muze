pub const TSLanguage = opaque {};
pub const TSParser   = opaque {};
pub const TSTree     = opaque {};

pub const TSNode = extern struct {
    context: [4]?*anyopaque,
    id: ?*anyopaque,
    tree: ?*const TSTree,
};

pub const TSPoint = extern struct {
    row: u32,
    column: u32,
};

pub extern fn ts_parser_new() ?*TSParser;
pub extern fn ts_parser_delete(p: ?*TSParser) void;
pub extern fn ts_parser_set_language(p: *TSParser, l: *const TSLanguage) bool;
pub extern fn ts_parser_parse_string(
    p: *TSParser,
    old: ?*const TSTree,
    src: [*]const u8,
    len: u32,
) ?*TSTree;
pub extern fn ts_tree_delete(t: ?*TSTree) void;
pub extern fn ts_tree_root_node(t: *const TSTree) TSNode;

pub extern fn ts_node_type(n: TSNode) [*:0]const u8;
pub extern fn ts_node_start_byte(n: TSNode) u32;
pub extern fn ts_node_end_byte(n: TSNode) u32;
pub extern fn ts_node_child_count(n: TSNode) u32;
pub extern fn ts_node_named_child_count(n: TSNode) u32;
pub extern fn ts_node_child(n: TSNode, i: u32) TSNode;
pub extern fn ts_node_named_child(n: TSNode, i: u32) TSNode;
pub extern fn ts_node_is_named(n: TSNode) bool;
pub extern fn ts_node_is_null(n: TSNode) bool;

pub extern fn tree_sitter_c() *const TSLanguage;
pub extern fn tree_sitter_cpp() *const TSLanguage;
pub extern fn tree_sitter_rust() *const TSLanguage;
