const std = @import("std");

pub const ExecResult = struct {
    exit_code: u8,
    signaled: bool,
    signal: u32,
    timed_out: bool,
};

pub fn exec(
    allocator: std.mem.Allocator,
    io: std.Io,
    cmd: []const u8,
    cwd: []const u8,
    timeout_s: u32,
    stdout_path: []const u8,
    stderr_path: []const u8,
) !ExecResult {
    const cwd_dir = std.Io.Dir.cwd();

    const timeout_str = try std.fmt.allocPrint(allocator, "{d}", .{timeout_s});
    defer allocator.free(timeout_str);

    const sh_cmd = try std.fmt.allocPrint(allocator, "cd {s} && {s}", .{cwd, cmd});
    defer allocator.free(sh_cmd);

    const perl_script =
        \\setpgrp;
        \\my $timeout = shift;
        \\my $pid = fork();
        \\if ($pid == 0) { exec @ARGV; exit 1; }
        \\local $SIG{ALRM} = sub { kill '-KILL', 0 };
        \\alarm $timeout;
        \\waitpid($pid, 0);
        \\alarm 0;
        \\my $s = $?;
        \\if ($s & 127) { exit(128 + ($s & 127)); } else { exit($s >> 8); }
    ;
    const res = try std.process.run(allocator, io, .{
        .argv = &.{ "perl", "-e", perl_script, timeout_str, "/bin/sh", "-c", sh_cmd },
    });
    defer allocator.free(res.stdout);
    defer allocator.free(res.stderr);

    try cwd_dir.writeFile(io, .{ .sub_path = stdout_path, .data = res.stdout });
    try cwd_dir.writeFile(io, .{ .sub_path = stderr_path, .data = res.stderr });

    switch (res.term) {
        .exited => |code| {
            return .{
                .exit_code = code,
                .signaled = false,
                .signal = 0,
                .timed_out = code == 124 or code == 142 or code == 137,
            };
        },
        .signal => |sig| {
            const sig_val = @intFromEnum(sig);
            return .{
                .exit_code = 0,
                .signaled = true,
                .signal = sig_val,
                .timed_out = sig_val == 14, // SIGALRM
            };
        },
        .stopped, .unknown => {
            return .{
                .exit_code = 0,
                .signaled = true,
                .signal = 0,
                .timed_out = false,
            };
        },
    }
}

pub fn copyTree(allocator: std.mem.Allocator, io: std.Io, src: []const u8, dst: []const u8) !void {
    const cwd = std.Io.Dir.cwd();
    cwd.deleteTree(io, dst) catch {};
    try cwd.createDirPath(io, dst);

    var src_dir = try cwd.openDir(io, src, .{ .iterate = true });
    defer src_dir.close(io);

    var walker = try src_dir.walk(allocator);
    defer walker.deinit();

    while (try walker.next(io)) |entry| {
        const rel = entry.path;

        var dst_path_buf = std.ArrayList(u8).empty;
        defer dst_path_buf.deinit(allocator);
        try dst_path_buf.appendSlice(allocator, dst);
        try dst_path_buf.append(allocator, '/');
        try dst_path_buf.appendSlice(allocator, rel);

        switch (entry.kind) {
            .directory => try cwd.createDirPath(io, dst_path_buf.items),
            .file => {
                if (std.fs.path.dirname(dst_path_buf.items)) |parent| {
                    try cwd.createDirPath(io, parent);
                }
                try entry.dir.copyFile(entry.basename, cwd, dst_path_buf.items, io, .{});
            },
            else => {},
        }
    }
}
