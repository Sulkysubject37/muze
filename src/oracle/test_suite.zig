const std = @import("std");
const sandbox = @import("../runner/sandbox.zig");
const Adapter = @import("../runner/adapter.zig").Adapter;
const Verdict = @import("../runner/classify.zig").Verdict;

pub fn run(
    allocator: std.mem.Allocator,
    io: std.Io,
    adapter: Adapter,
    mutant_dir: []const u8,
    run_dir: []const u8,
) !Verdict {
    // 1. Build
    var build_stdout = std.ArrayList(u8).empty;
    defer build_stdout.deinit(allocator);
    try build_stdout.appendSlice(allocator, run_dir);
    try build_stdout.appendSlice(allocator, "/build.stdout");

    var build_stderr = std.ArrayList(u8).empty;
    defer build_stderr.deinit(allocator);
    try build_stderr.appendSlice(allocator, run_dir);
    try build_stderr.appendSlice(allocator, "/build.stderr");

    const build_res = try sandbox.exec(
        allocator,
        io,
        adapter.build_cmd,
        mutant_dir,
        adapter.build_timeout_s,
        build_stdout.items,
        build_stderr.items,
    );

    if (build_res.timed_out) return .timeout;
    if (build_res.signaled or build_res.exit_code != 0) return .invalid;

    // 2. Test
    var test_stdout = std.ArrayList(u8).empty;
    defer test_stdout.deinit(allocator);
    try test_stdout.appendSlice(allocator, run_dir);
    try test_stdout.appendSlice(allocator, "/test.stdout");

    var test_stderr = std.ArrayList(u8).empty;
    defer test_stderr.deinit(allocator);
    try test_stderr.appendSlice(allocator, run_dir);
    try test_stderr.appendSlice(allocator, "/test.stderr");

    const test_res = try sandbox.exec(
        allocator,
        io,
        adapter.test_cmd,
        mutant_dir,
        adapter.test_timeout_s,
        test_stdout.items,
        test_stderr.items,
    );

    if (test_res.timed_out) return .timeout;
    if (test_res.signaled) return .killed;
    if (test_res.exit_code != 0) return .killed;
    return .survived;
}
