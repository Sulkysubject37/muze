// Created by Sulkysubject37
const std = @import("std");
const json = @import("json.zig");

pub fn write(
    allocator: std.mem.Allocator,
    io: std.Io,
    path: []const u8,
    report: json.ToolReport,
) !void {
    var a = std.Io.Writer.Allocating.init(allocator);
    defer a.deinit();
    const w = &a.writer;

    try w.print("# MUZE — {s} mutation report\n\n", .{report.tool});
    try w.print("## Aggregate\n\n", .{});
    try w.print("| Verdict | Count |\n|---|---|\n", .{});
    try w.print("| Killed  | {d} |\n", .{report.killed});
    try w.print("| Survived| {d} |\n", .{report.survived});
    try w.print("| Invalid | {d} |\n", .{report.invalid});
    try w.print("| Timeout | {d} |\n", .{report.timeout});
    try w.print("| Total   | {d} |\n\n", .{report.total});

    try w.print("## Per-mutant\n\n", .{});
    try w.print("| id | file | operator | class | verdict |\n|---|---|---|---|---|\n", .{});
    for (report.mutants) |m| {
        try w.print(
            "| {d} | {s} | {s} | {s} | {s} |\n",
            .{ m.id, m.file, m.operator, m.class, m.verdict },
        );
    }

    try std.Io.Dir.cwd().writeFile(io, .{ .sub_path = path, .data = w.buffered() });
}
