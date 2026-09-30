const std = @import("std");

pub fn getFileHash(path: [*:0]const u8) ![32]u8 {
    const fp = std.c.fopen(path, "rb") orelse return error.FileOpenError;
    defer _ = std.c.fclose(fp);
    var hasher = std.crypto.hash.sha2.Sha256.init(.{});
    var buf: [4096]u8 = undefined;
    while (true) {
        const bytes_read = std.c.fread(&buf, 1, buf.len, fp);
        if (bytes_read == 0) break;
        hasher.update(buf[0..bytes_read]);
    }
    var final_hash: [32]u8 = undefined;
    hasher.final(&final_hash);
    return final_hash;
}
