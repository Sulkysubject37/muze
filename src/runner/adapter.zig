const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;

pub const Adapter = struct {
    name: []const u8,
    source_root: []const u8,

    lang: Lang,
    extensions: []const []const u8,
    source_dirs: []const []const u8,
    skip_dirs: []const []const u8,

    baseline_build_cmd: []const u8,
    
    compile_db: ?[]const u8 = null,
    compile_cmd_for: ?*const fn (alloc: std.mem.Allocator, file: []const u8) []const u8 = null,
    obj_path_for: *const fn (alloc: std.mem.Allocator, file: []const u8) []const u8,
    link_cmd: []const u8,

    test_cmd: []const u8,

    build_timeout_s: u32,
    test_timeout_s: u32,

    smoke_cmd: []const u8,

    pub fn fromName(name_str: []const u8) !Adapter {
        if (std.mem.eql(u8, name_str, "samtools"))
            return @import("../tools/samtools.zig").adapter;
        if (std.mem.eql(u8, name_str, "gromacs"))
            return @import("../tools/gromacs.zig").adapter;
        return error.UnknownTool;
    }
};
