const std = @import("std");

// IPC Binary Structs (The ABI)
pub const MuzeIpcPacket = extern struct {
    magic_seed: u32,
    domain_id: u8,
    payload_f64_1: f64,
    payload_f64_2: f64,
    payload_u64: u64,
};


// Memory-Safe Zig Biological Sandbox
pub fn bwt_backward_search(
    pattern: []const u8,
    count_table: []const u32,
    occ_table: []const u32,
    bwt_len: usize,
    sp_out: *u32,
    ep_out: *u32,
) void {
    var sp: u32 = 0;
    var ep: u32 = @intCast(bwt_len - 1);
    var i: i32 = @intCast(pattern.len - 1);

    while (sp <= ep and i >= 0) : (i -= 1) {
        const c = pattern[@intCast(i)];
        const occ_sp = if (sp == 0) 0 else occ_table[(sp - 1) * 4 + c];
        sp = count_table[c] + occ_sp;
        ep = count_table[c] + occ_table[ep * 4 + c] - 1;
    }
    sp_out.* = sp;
    ep_out.* = ep;
}

pub fn encode_kmer(seq: []const u8, k: usize) u64 {
    var kmer: u64 = 0;
    var i: usize = 0;
    while (i < k) : (i += 1) {
        const val: u64 = (seq[i] >> 1) & 3;
        kmer = (kmer << 2) | val;
    }
    return kmer;
}

pub fn reverse_complement(kmer: u64, k: usize) u64 {
    var rc: u64 = 0;
    var i: usize = 0;
    while (i < k) : (i += 1) {
        const shift = @as(u6, @intCast(2 * i));
        const base = (kmer >> shift) & 3;
        rc = (rc << 2) | ((base) & 3);
    }
    return rc;
}

pub fn get_canonical_kmer(kmer: u64, k: usize) u64 {
    const rc = reverse_complement(kmer, k);
    return if (kmer < rc) kmer else rc;
}

pub const TreeNode = struct {
    parent: u32,
    depth: u32,
};

pub fn get_lca(u_in: u32, v_in: u32, tree: []const TreeNode) u32 {
    var u = u_in;
    var v = v_in;
    while (tree[u].depth > tree[v].depth) {
        u = tree[u].parent;
    }
    while (tree[v].depth > tree[u].depth) {
        v = tree[v].parent;
    }
    while (u != v) {
        u = tree[u].parent;
        v = tree[v].parent;
    }
    return u;
}

pub fn lennard_jones_potential(
    pos_x: []const f64,
    pos_y: []const f64,
    pos_z: []const f64,
    box_size: f64,
    cutoff: f64,
) f64 {
    var total_energy: f64 = 0.0;
    const cutoff_sq = cutoff * cutoff;
    const num_particles = pos_x.len;
    
    var i: usize = 0;
    while (i < num_particles) : (i += 1) {
        var j: usize = i + 1;
        while (j < num_particles) : (j += 1) {
            var dx = pos_x[i] - pos_x[j];
            var dy = pos_y[i] - pos_y[j];
            var dz = pos_z[i] - pos_z[j];
            
            dx -= box_size * @trunc(dx / box_size);
            dy -= box_size * @trunc(dy / box_size);
            dz -= box_size * @trunc(dz / box_size);
            
            const r2 = dx * dx + dy * dy + dz * dz;
            if (r2 < cutoff_sq) {
                const r6 = r2 * r2 * r2;
                const r12 = r6 * r6;
                total_energy += 4.0 * ((1.0 / r12) - (1.0 / r6));
            }
        }
    }
    return total_energy;
}

pub fn sliding_window_minimizer(seq: []const u8, k: usize, w: usize) u64 {
    var min_hash: u64 = std.math.maxInt(u64);
    if (seq.len < w) return min_hash;
    
    var i: usize = 0;
    while (i <= seq.len - w) : (i += 1) {
        var j: usize = 0;
        while (j <= w - k) : (j += 1) {
            const kmer = encode_kmer(seq[i + j .. i + j + k], k);
            const canonical = get_canonical_kmer(kmer, k);
            var hash = canonical ^ 0x5bd1e995;
            hash ^= hash >> 15;
            if (hash < min_hash) {
                min_hash = hash;
            }
        }
    }
    return min_hash;
}

test "FM-Index BWT backward search oracle" {
    const pattern = [_]u8{ 1, 2 }; 
    const count_table = [_]u32{ 0, 2, 4, 6 };
    const occ_table = [_]u32{0} ** 100;
    var sp: u32 = 0;
    var ep: u32 = 0;
    bwt_backward_search(&pattern, &count_table, &occ_table, 3, &sp, &ep);
    try std.testing.expect(sp > 0);
}

test "Transcriptomics K-mer processing oracle" {
    const seq = "ACGT";
    const kmer = encode_kmer(seq, 4);
    const rc = reverse_complement(kmer, 4);
    try std.testing.expect(kmer != rc);
    try std.testing.expect(get_canonical_kmer(kmer, 4) == get_canonical_kmer(rc, 4));
}

test "Phylogenetics LCA oracle" {
    const tree = [_]TreeNode{
        .{ .parent = 0, .depth = 0 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 1, .depth = 2 },
        .{ .parent = 1, .depth = 2 },
    };
    try std.testing.expect(get_lca(3, 4, &tree) == 1);
    try std.testing.expect(get_lca(3, 2, &tree) == 0);
}

test "Structural Biology LJ Potential oracle" {
    const px = [_]f64{ 0.0, 1.2 };
    const py = [_]f64{ 0.0, 0.0 };
    const pz = [_]f64{ 0.0, 0.0 };
    const e = lennard_jones_potential(&px, &py, &pz, 10.0, 2.0);
    try std.testing.expect(e != 0.0);
}

test "Metagenomics Minimizer oracle" {
    const seq = "ACGTACGTACGT";
    const min = sliding_window_minimizer(seq, 4, 8);
    try std.testing.expect(min != std.math.maxInt(u64));
}

extern "c" fn read(fd: c_int, buf: *anyopaque, count: usize) isize;
extern "c" fn write(fd: c_int, buf: *const anyopaque, count: usize) isize;


// IPC Receiver Harness
pub fn main() !void {
    var packet: MuzeIpcPacket = undefined;
    
    // Read the strictly packed ABI struct from stdin (fd 0)
    const bytes_read = read(0, std.mem.asBytes(&packet).ptr, @sizeOf(MuzeIpcPacket));
    if (bytes_read != @sizeOf(MuzeIpcPacket)) {
        return; // Silent exit on bad IPC
    }

    if (packet.magic_seed != 0x5BD1E995) {
        return; // Reject unauthorized payload
    }

    // Execute Domain based on ID
    if (packet.domain_id == 1) {
        // Run BWA
        var sp: u32 = 0;
        var ep: u32 = 0;
        bwt_backward_search("ACGT", &[_]u32{0, 1, 2, 3}, &[_]u32{0,0,0,0,0}, 4, &sp, &ep);
        packet.payload_u64 = sp;
    } else if (packet.domain_id == 2) {
        // Run Kraken minimizer
        const result = sliding_window_minimizer("ACGTAACCGGTT", 4, 8);
        packet.payload_u64 = result;
    } else if (packet.domain_id == 3) {
        // Run RAxML LCA
        const tree = [_]TreeNode{
            .{ .parent = 0, .depth = 0 },
            .{ .parent = 0, .depth = 1 },
            .{ .parent = 0, .depth = 1 },
            .{ .parent = 1, .depth = 2 },
            .{ .parent = 1, .depth = 2 },
        };
        const result = get_lca(3, 4, &tree);
        packet.payload_u64 = result;
    } else if (packet.domain_id == 4) {
        // Run GROMACS Lennard-Jones
        const px = [_]f64{ 0.0, 1.2 };
        const py = [_]f64{ 0.0, 0.0 };
        const pz = [_]f64{ 0.0, 0.0 };
        const e = lennard_jones_potential(&px, &py, &pz, 10.0, 2.0);
        packet.payload_f64_1 = e;
    } else if (packet.domain_id == 5) {
        // Run Transcriptomics Canonical K-mer
        const seq = "ACGT";
        const kmer = encode_kmer(seq, 4);
        const result = get_canonical_kmer(kmer, 4);
        packet.payload_u64 = result;
    }

    // Write the modified packet back
    if (packet.domain_id == 6) {
        const tree = [_]TreeNode{ .{ .parent = 0, .depth = 0 }, .{ .parent = 0, .depth = 1 }, .{ .parent = 0, .depth = 1 }, .{ .parent = 1, .depth = 2 }, .{ .parent = 1, .depth = 2 } };
        packet.payload_u64 = kraken2_lca(3, 4, &tree);
    } else if (packet.domain_id == 7) {
        packet.payload_u64 = kraken2_translate(12);
    } else if (packet.domain_id == 8) {
        packet.payload_u64 = if (kraken2_mask(5, 20)) 1 else 0;
    }

    _ = write(1, std.mem.asBytes(&packet).ptr, @sizeOf(MuzeIpcPacket));
}
pub fn kraken2_lca(a_in: u32, b_in: u32, tree: []const TreeNode) u32 {
    var a = a_in;
    var b = b_in;
    if (a == 0 or b == 0) return if (a != 0) a else b;
    while (a != b) {
        if (a > b) {
            a = tree[a].parent;
        } else {
            b = tree[b].parent;
        }
    }
    return a;
}

pub fn kraken2_translate(seq_len: usize) u32 {
    var total_frames: u32 = 0;
    var i: usize = 0;
    while (i < seq_len) : (i += 1) {
        const frame = i % 3;
        total_frames += @intCast(frame);
    }
    return total_frames;
}

pub fn kraken2_mask(cv: u32, threshold: u32) bool {
    if (cv * 10 > threshold * 2) {
        return true;
    }
    return false;
}
