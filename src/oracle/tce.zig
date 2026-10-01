const std = @import("std");

pub fn hashFile(alloc: std.mem.Allocator, io: std.Io, cwd: std.Io.Dir, path: []const u8) ![32]u8 {
    const bytes = try cwd.readFileAlloc(io, path, alloc, @enumFromInt(512 * 1024 * 1024));
    defer alloc.free(bytes);

    var hasher = std.crypto.hash.sha2.Sha256.init(.{});
    hasher.update(bytes);
    var out: [32]u8 = undefined;
    hasher.final(&out);
    return out;
}
