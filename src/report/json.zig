const std = @import("std");

pub const MutantRecord = struct {
    id: u32,
    file: []const u8,
    operator: []const u8,
    class: []const u8,
    op_start: u32,
    op_end: u32,
    verdict: []const u8,
};

pub const ToolReport = struct {
    tool: []const u8,
    total: u32,
    killed: u32,
    survived: u32,
    invalid: u32,
    timeout: u32,
    mutants: []const MutantRecord,
};

pub fn write(
    allocator: std.mem.Allocator,
    io: std.Io,
    path: []const u8,
    report: ToolReport,
) !void {
    var a = std.Io.Writer.Allocating.init(allocator);
    defer a.deinit();
    const w = &a.writer;

    try w.print("{{\n", .{});
    try w.print("  \"tool\": \"{s}\",\n", .{report.tool});
    try w.print("  \"total\": {d},\n", .{report.total});
    try w.print("  \"killed\": {d},\n", .{report.killed});
    try w.print("  \"survived\": {d},\n", .{report.survived});
    try w.print("  \"invalid\": {d},\n", .{report.invalid});
    try w.print("  \"timeout\": {d},\n", .{report.timeout});
    try w.print("  \"mutants\": [\n", .{});
    for (report.mutants, 0..) |m, i| {
        try w.print(
            "    {{\"id\":{d},\"file\":\"{s}\",\"operator\":\"{s}\",\"class\":\"{s}\",\"verdict\":\"{s}\"}}",
            .{ m.id, m.file, m.operator, m.class, m.verdict },
        );
        if (i + 1 < report.mutants.len) try w.print(",", .{});
        try w.print("\n", .{});
    }
    try w.print("  ]\n}}\n", .{});

    try std.Io.Dir.cwd().writeFile(io, .{ .sub_path = path, .data = w.buffered() });
}
