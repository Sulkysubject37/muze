const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const classify = @import("classify.zig");

pub const ToolAdapter = struct {
    name: []const u8,
    lang: Lang,
    
    source_dirs: []const []const u8,
    skip_dirs: []const []const u8,
    source_root: []const u8,
    extensions: []const []const u8, // Explicitly restricts headers e.g. &.{".c", ".cpp"}
    
    max_workers: u8,
    baseline_build_cmd: []const u8,
    build_timeout_s: u32, // Enforces memory-bounded concurrency limit
    
    // Lifecycle hooks
    initWorker: *const fn(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8, baseline_dir: []const u8) anyerror!void,
    compileMutant: *const fn(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8, worker_dir: []const u8) anyerror![]const u8,
    linkTarget: *const fn(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool,
    runTests: *const fn(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict,
    
    pub fn fromName(name_str: []const u8) !ToolAdapter {
        if (std.mem.eql(u8, name_str, "samtools"))
            return @import("../tools/samtools.zig").adapter;
        if (std.mem.eql(u8, name_str, "gromacs"))
            return @import("../tools/gromacs.zig").adapter;
        if (std.mem.eql(u8, name_str, "iqtree"))
            return @import("../tools/iqtree.zig").adapter;
        if (std.mem.eql(u8, name_str, "bwa"))
            return @import("../tools/bwa.zig").adapter;
        if (std.mem.eql(u8, name_str, "raxml"))
            return @import("../tools/raxml.zig").adapter;
        return error.UnknownTool;
    }
};
