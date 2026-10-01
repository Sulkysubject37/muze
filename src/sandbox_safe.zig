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
        if (bwt_len == 0) {
        sp_out.* = 0;
        ep_out.* = 0;
        return;
    }
	var sp: u32 = 0;
    	var ep: u32 = @intCast(bwt_len - 1);
    	var i: i32 = @intCast(pattern.len - 1);

    while (sp <= ep and i >= 0) : (i -= 1) {
        const c: u32 = @intCast((pattern[@intCast(i)] >> 1) & 3);
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
        rc = (rc << 2) | ((~base) & 3);
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
    if (u == 0 or v == 0) return if (u != 0) u else v;
    while (u != v) {
        if (u > v) u = tree[u].parent
        else       v = tree[v].parent;
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

test "domain_1" {
    const count_table = [_]u32{ 0, 1, 2, 3 };
    const occ_table = [_]u32{0} ** 16;
    var sp: u32 = 0;
    var ep: u32 = 0;
    bwt_backward_search("ACGT", &count_table, &occ_table, 4, &sp, &ep);
    try std.testing.expect(sp == 2);
}

test "domain_2" {
    try std.testing.expect(sliding_window_minimizer("ACGTAACCGGTT", 4, 8) == 1540447777);
}

test "domain_3" {
    const tree = [_]TreeNode{
        .{ .parent = 0, .depth = 0 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 1, .depth = 2 },
        .{ .parent = 1, .depth = 2 },
    };
    try std.testing.expect(get_lca(3, 4, &tree) == 1);
}

test "domain_4" {
    const px = [_]f64{ 0.0, 1.2 };
    const py = [_]f64{ 0.0, 0.0 };
    const pz = [_]f64{ 0.0, 0.0 };
    try std.testing.expect(lennard_jones_potential(&px, &py, &pz, 10.0, 2.0) == -0.890965287583076);
}

test "domain_5" {
    try std.testing.expect(get_canonical_kmer(encode_kmer("ACGT", 4), 4) == 30);
}

test "domain_6" {
    const tree = [_]TreeNode{
        .{ .parent = 0, .depth = 0 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 0, .depth = 1 },
        .{ .parent = 1, .depth = 2 },
        .{ .parent = 1, .depth = 2 },
    };
    try std.testing.expect(get_lca(3, 4, &tree) == 1);
}

test "domain_7" { try std.testing.expect(kraken2_translate(12) == 12); }
test "domain_8" { try std.testing.expect(kraken2_mask(5, 20) == false); }
test "domain_9" { try std.testing.expect(jellyfish_canonical_kmer(0) == 0); }
test "domain_10" { try std.testing.expect(jellyfish_bloom_filter(0) == 0); }
test "domain_11" { try std.testing.expect(jellyfish_cas_counter(0) == 1); }
test "domain_12" { try std.testing.expect(kallisto_ec_intersect(0xF0F0, 0xAAAA) == 41120); }
test "domain_13" { try std.testing.expect(kallisto_em_noise_truncate(0.05, 0.05) == 0.05); }
test "domain_14" { try std.testing.expect(kallisto_effective_length_normalize(100.0, 0.5) == 100); }
test "domain_15" { try std.testing.expect(kallisto_kmer_odd_constraint(31) == 1); }
test "domain_16" { try std.testing.expect(kallisto_strand_flip(0x12345678, false) == 2452903544); }
test "domain_17" { try std.testing.expect(kallisto_umi_match(1, 1) == 1); }
test "domain_18" { try std.testing.expect(samtools_bed_overlap(5, 0, 5) == 0); }
test "domain_19" { try std.testing.expect(samtools_vcf_coordinate(100) == 101); }
test "domain_20" { try std.testing.expect(samtools_is_reverse(0) == 0); }
test "domain_21" { try std.testing.expect(samtools_iupac_match(15, 15) == 0); }
test "domain_22" { try std.testing.expect(samtools_unclipped_pos(100, 10, true) == 90); }
test "domain_23" { try std.testing.expect(samtools_proper_pair(0, 0) == 0); }
test "domain_24" { try std.testing.expect(bwa_sentinel_shift(5, 5) == 4); }
test "domain_25" { try std.testing.expect(bwa_n_filter(4) == 0); }
test "domain_26" { try std.testing.expect(bwa_gap_penalty(5, 2, 3) == 11); }
test "domain_27" { try std.testing.expect(bwa_simd_saturated(250, 5) == 1); }
test "domain_28" { try std.testing.expect(bwa_chain_gap_valid(10, 10) == 1); }
test "domain_29" { try std.testing.expect(bwa_pair_strand_code(1, 3) == 2); }
test "domain_30" { try std.testing.expect(bwa_insert_lower_bound(100.0, 200.0, 1.5) == -50); }
test "domain_31" { try std.testing.expect(salmon_rc_index(2, 10) == 7); }
test "domain_32" { try std.testing.expect(salmon_ec_filter(1) == 1); }
test "domain_33" { try std.testing.expect(salmon_em_converged(0.05, 0.05) == 0); }
test "domain_34" { try std.testing.expect(salmon_rad_pack(3, 1) == 3); }
test "domain_35" { try std.testing.expect(salmon_mask_base(88) == 78); }
test "domain_36" { try std.testing.expect(salmon_cigar_state(1) == 3); }
test "domain_37" { try std.testing.expect(gromacs_leapfrog_step(1.0, 2.0, 0.5) == 2); }
test "domain_38" { try std.testing.expect(gromacs_vrescale_lambda(1.0, 4.0) == 0.5); }
test "domain_39" { try std.testing.expect(gromacs_pbc_wrap(5.5, 0.1) == 5.5); }
test "domain_40" { try std.testing.expect(gromacs_halo_buffer_size(8) == 9); }
test "domain_41" { try std.testing.expect(gromacs_fudge_qq(10.0, 0.5) == 5); }
test "domain_42" { try std.testing.expect(gromacs_spring_force(2.0, 3.0) == -6); }
test "domain_43" { try std.testing.expect(foldseek_cbeta_geometry(1.0, 2.0) == 0.666667); }
test "domain_44" { try std.testing.expect(foldseek_lddt_inclusion(10.0, 3, 5) == 1); }
test "domain_45" { try std.testing.expect(foldseek_tm_filter(-1, 20.0, 4.0) == 0); }
test "domain_46" { try std.testing.expect(foldseek_gap_penalty_sat(10, 20) == 0); }
test "domain_47" { try std.testing.expect(foldseek_bfactor_mask(50.0, 70.0) == 1); }
test "domain_48" { try std.testing.expect(foldseek_evalue_mu(2.0) == 0.85); }
test "domain_49" { try std.testing.expect(raxml_freq_invalid(1.0) == 1); }
test "domain_50" { try std.testing.expect(raxml_rate_normalize(10.0, 2.0) == 5); }
test "domain_51" { try std.testing.expect(raxml_branch_clamp(5.0, 0.0, 10.0) == 5); }
test "domain_52" { try std.testing.expect(raxml_improvement_check(5.0, 4.0, 1.0) == 0); }
test "domain_53" { try std.testing.expect(raxml_tie_break(5.0, 5.0) == 0); }
test "domain_54" { try std.testing.expect(raxml_split_conflict(0) == 1); }
test "domain_55" { try std.testing.expect(iqtree_bootstrap_replace(1) == 1); }
test "domain_56" { try std.testing.expect(iqtree_underflow_scale(0.5, 0.01) == 0.5); }
test "domain_57" { try std.testing.expect(iqtree_align_offset(0xFF, 0x0F) == 15); }
test "domain_58" { try std.testing.expect(iqtree_nni_symmetric_update(3, 7, 1) == 703); }
test "domain_59" { try std.testing.expect(iqtree_branch_clamp(0.0) == 0.000001); }
test "domain_60" { try std.testing.expect(iqtree_weight_normalize(0.3, 3.0) == 0.09999999999999999); }

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
        const count_table = [_]u32{ 0, 1, 2, 3 };
        // occ_table must be bwt_len * 4 entries. bwt_len = 4 → 16 entries minimum.
        const occ_table = [_]u32{
            0, 0, 0, 0, // row 0
            0, 0, 0, 0, // row 1
            0, 0, 0, 0, // row 2
            0, 0, 0, 0, // row 3
        };
        bwt_backward_search("ACGT", &count_table, &occ_table, 4, &sp, &ep);
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
    } else if (packet.domain_id == 6) {
        const tree = [_]TreeNode{
            .{ .parent = 0, .depth = 0 },
            .{ .parent = 0, .depth = 1 },
            .{ .parent = 0, .depth = 1 },
            .{ .parent = 1, .depth = 2 },
            .{ .parent = 1, .depth = 2 },
        };
        packet.payload_u64 = get_lca(3, 4, &tree);
    } else if (packet.domain_id == 7) {
        packet.payload_u64 = kraken2_translate(12);
    } else if (packet.domain_id == 8) {
        packet.payload_u64 = if (kraken2_mask(5, 20)) 1 else 0;
    } else if (packet.domain_id == 9) {
        packet.payload_u64 = jellyfish_canonical_kmer(packet.payload_u64);
    } else if (packet.domain_id == 10) {
        packet.payload_u64 = jellyfish_bloom_filter(packet.payload_u64);
    } else if (packet.domain_id == 11) {
        packet.payload_u64 = jellyfish_cas_counter(packet.payload_u64);
    } else if (packet.domain_id == 12) {
        packet.payload_u64 = kallisto_ec_intersect(0xF0F0, 0xAAAA);
    } else if (packet.domain_id == 13) {
        packet.payload_f64_1 = kallisto_em_noise_truncate(0.05, 0.05);
    } else if (packet.domain_id == 14) {
        packet.payload_f64_1 = kallisto_effective_length_normalize(100.0, 0.5);
    } else if (packet.domain_id == 15) {
        packet.payload_u64 = kallisto_kmer_odd_constraint(31);
    } else if (packet.domain_id == 16) {
        packet.payload_u64 = kallisto_strand_flip(0x12345678, false);
    } else if (packet.domain_id == 17) {
        packet.payload_u64 = kallisto_umi_match(1, 1);
    } else if (packet.domain_id == 18) {
        packet.payload_u64 = samtools_bed_overlap(5, 0, 5);
    } else if (packet.domain_id == 19) {
        packet.payload_u64 = samtools_vcf_coordinate(100);
    } else if (packet.domain_id == 20) {
        packet.payload_u64 = samtools_is_reverse(0);
    } else if (packet.domain_id == 21) {
        packet.payload_u64 = samtools_iupac_match(15, 15);
    } else if (packet.domain_id == 22) {
        packet.payload_u64 = samtools_unclipped_pos(100, 10, true);
    } else if (packet.domain_id == 23) {
        packet.payload_u64 = samtools_proper_pair(0, 0);
    } else if (packet.domain_id == 24) {
        packet.payload_u64 = bwa_sentinel_shift(5, 5);
    } else if (packet.domain_id == 25) {
        packet.payload_u64 = bwa_n_filter(4);
    } else if (packet.domain_id == 26) {
        packet.payload_u64 = bwa_gap_penalty(5, 2, 3);
    } else if (packet.domain_id == 27) {
        packet.payload_u64 = bwa_simd_saturated(250, 5);
    } else if (packet.domain_id == 28) {
        packet.payload_u64 = bwa_chain_gap_valid(10, 10);
    } else if (packet.domain_id == 29) {
        packet.payload_u64 = bwa_pair_strand_code(1, 3);
    } else if (packet.domain_id == 30) {
        packet.payload_f64_1 = bwa_insert_lower_bound(100.0, 200.0, 1.5);
    } else if (packet.domain_id == 31) {
        packet.payload_u64 = salmon_rc_index(2, 10);
    } else if (packet.domain_id == 32) {
        packet.payload_u64 = salmon_ec_filter(1);
    } else if (packet.domain_id == 33) {
        packet.payload_u64 = salmon_em_converged(0.05, 0.05);
    } else if (packet.domain_id == 34) {
        packet.payload_u64 = salmon_rad_pack(3, 1);
    } else if (packet.domain_id == 35) {
        packet.payload_u64 = salmon_mask_base(88);
    } else if (packet.domain_id == 36) {
        packet.payload_u64 = salmon_cigar_state(1);
    } else if (packet.domain_id == 37) {
        packet.payload_f64_1 = gromacs_leapfrog_step(1.0, 2.0, 0.5);
    } else if (packet.domain_id == 38) {
        packet.payload_f64_1 = gromacs_vrescale_lambda(1.0, 4.0);
    } else if (packet.domain_id == 39) {
        packet.payload_f64_1 = gromacs_pbc_wrap(5.5, 0.1);
    } else if (packet.domain_id == 40) {
        packet.payload_u64 = gromacs_halo_buffer_size(8);
    } else if (packet.domain_id == 41) {
        packet.payload_f64_1 = gromacs_fudge_qq(10.0, 0.5);
    } else if (packet.domain_id == 42) {
        packet.payload_f64_1 = gromacs_spring_force(2.0, 3.0);
    } else if (packet.domain_id == 43) {
        packet.payload_f64_1 = foldseek_cbeta_geometry(1.0, 2.0);
    } else if (packet.domain_id == 44) {
        packet.payload_u64 = foldseek_lddt_inclusion(10.0, 3, 5);
    } else if (packet.domain_id == 45) {
        packet.payload_u64 = foldseek_tm_filter(-1, 20.0, 4.0);
    } else if (packet.domain_id == 46) {
        packet.payload_u64 = foldseek_gap_penalty_sat(10, 20);
    } else if (packet.domain_id == 47) {
        packet.payload_u64 = foldseek_bfactor_mask(50.0, 70.0);
    } else if (packet.domain_id == 48) {
        packet.payload_f64_1 = foldseek_evalue_mu(2.0);
    } else if (packet.domain_id == 49) {
        packet.payload_u64 = raxml_freq_invalid(1.0);
    } else if (packet.domain_id == 50) {
        packet.payload_f64_1 = raxml_rate_normalize(10.0, 2.0);
    } else if (packet.domain_id == 51) {
        packet.payload_f64_1 = raxml_branch_clamp(5.0, 0.0, 10.0);
    } else if (packet.domain_id == 52) {
        packet.payload_u64 = raxml_improvement_check(5.0, 4.0, 1.0);
    } else if (packet.domain_id == 53) {
        packet.payload_u64 = raxml_tie_break(5.0, 5.0);
    } else if (packet.domain_id == 54) {
        packet.payload_u64 = raxml_split_conflict(0);
    } else if (packet.domain_id == 55) {
        packet.payload_u64 = iqtree_bootstrap_replace(1);
    } else if (packet.domain_id == 56) {
        packet.payload_f64_1 = iqtree_underflow_scale(0.5, 0.01);
    } else if (packet.domain_id == 57) {
        packet.payload_u64 = iqtree_align_offset(0xFF, 0x0F);
    } else if (packet.domain_id == 58) {
        packet.payload_u64 = iqtree_nni_symmetric_update(3, 7, 1);
    } else if (packet.domain_id == 59) {
        packet.payload_f64_1 = iqtree_branch_clamp(0.0);
    } else if (packet.domain_id == 60) {
        packet.payload_f64_1 = iqtree_weight_normalize(0.3, 3.0);
    }

    _ = write(1, std.mem.asBytes(&packet).ptr, @sizeOf(MuzeIpcPacket));
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

pub fn jellyfish_canonical_kmer(kmer_in: u64) u64 {
    const rc = ~kmer_in;
    var canonical = kmer_in;
    if (rc < kmer_in) {
        canonical = rc;
    }
    return canonical;
}

pub fn jellyfish_bloom_filter(hash_val: u64) u64 {
    const k_hashes = 3;
    var pos = hash_val;
    var i: usize = 0;
    while (i < k_hashes) : (i += 1) {
        pos = (pos * 17) % 1024;
    }
    return pos;
}

pub fn jellyfish_cas_counter(val: u64) u64 {
    const max_count: u64 = 255;
    var count = val;
    if (count < max_count) {
        count += 1;
    }
    return count;
}

// --- Kallisto ---

pub fn kallisto_ec_intersect(read_set: u32, ec_set: u32) u32 {
    var result: u32 = 0;
    var i: u6 = 0;
    while (i < 32) : (i += 1) {
        const mask: u32 = @as(u32, 1) << @as(u5, @intCast(i));
        if ((read_set & mask) != 0 and (ec_set & mask) != 0) {
            result |= mask;
        }
    }
    return result;
}

pub fn kallisto_em_noise_truncate(prob: f64, noise_limit: f64) f64 {
    if (prob < noise_limit) {
        return 0.0;
    }
    return prob;
}

pub fn kallisto_effective_length_normalize(count: f64, eff_len_in: f64) f64 {
    var eff_len = eff_len_in;
    if (eff_len < 1.0) {
        eff_len = 1.0;
    }
    return count / eff_len;
}

pub fn kallisto_kmer_odd_constraint(k: u32) u8 {
    if (k % 2 != 0 and k >= 3) {
        return 1;
    }
    return 0;
}

pub fn kallisto_strand_flip(pos: u32, forward: bool) u32 {
    var packed_pos: u32 = pos & 0x7FFFFFFF;
    if (!forward) {
        packed_pos |= 0x80000000;
    }
    return packed_pos;
}

pub fn kallisto_umi_match(dist: u32, threshold: u32) u8 {
    if (dist <= threshold) {
        return 1;
    }
    return 0;
}

// --- SAMtools ---

pub fn samtools_bed_overlap(pos: u32, beg: u32, end: u32) u8 {
    if (pos >= beg and pos < end) {
        return 1;
    }
    return 0;
}

pub fn samtools_vcf_coordinate(pos: u32) u32 {
    return pos + 1;
}

pub fn samtools_is_reverse(flag: u32) u8 {
    if ((flag & 0x10) != 0) {
        return 1;
    }
    return 0;
}

pub fn samtools_iupac_match(c1: u8, c2: u8) u8 {
    if (c1 == c2 and c2 != 15) {
        return 1;
    }
    return 0;
}

pub fn samtools_unclipped_pos(pos: u32, clip_len: u32, use_unclipped: bool) u32 {
    if (use_unclipped) {
        return pos - clip_len;
    }
    return pos;
}

pub fn samtools_proper_pair(flag1: u32, flag2: u32) u8 {
    if ((flag1 & 0x10) == 0 and (flag2 & 0x10) != 0) {
        return 1;
    }
    return 0;
}

// --- BWA ---

pub fn bwa_sentinel_shift(k_in: u32, primary: u32) u32 {
    var k = k_in;
    if (k >= primary) {
        k -= 1;
    }
    return k;
}

pub fn bwa_n_filter(base_code: u8) u8 {
    if (base_code < 4) {
        return 1;
    }
    return 0;
}

pub fn bwa_gap_penalty(q: u32, r: u32, n_ext: u32) u32 {
    return q + r * n_ext;
}

pub fn bwa_simd_saturated(gmax: u32, shift: u32) u8 {
    if (gmax + shift >= 255 or gmax >= 255) {
        return 1;
    }
    return 0;
}

pub fn bwa_chain_gap_valid(x: u32, bw: u32) u8 {
    if (x <= bw) {
        return 1;
    }
    return 0;
}

pub fn bwa_pair_strand_code(r1: u32, r2: u32) u32 {
    return r1 ^ r2;
}

pub fn bwa_insert_lower_bound(p25: f64, p75: f64, bound: f64) f64 {
    return p25 - bound * (p75 - p25);
}

// --- Salmon ---

pub fn salmon_rc_index(idx: u32, seq_len: u32) u32 {
    return seq_len - 1 - idx;
}

pub fn salmon_ec_filter(is_compat: u8) u8 {
    if (is_compat == 1) {
        return 1;
    }
    return 0;
}

pub fn salmon_em_converged(alpha: f64, cutoff: f64) u8 {
    if (alpha > cutoff) {
        return 1;
    }
    return 0;
}

pub fn salmon_rad_pack(tid: u32, ori_fw: u32) u32 {
    return tid | (ori_fw << 1);
}

pub fn salmon_mask_base(base: u8) u8 {
    if (base >= 65 and base <= 84) {
        return base;
    }
    return 78;
}

pub fn salmon_cigar_state(op: u8) u8 {
    if (op == 1) {
        return 3;
    }
    return op;
}

// --- GROMACS ---

pub fn gromacs_leapfrog_step(x: f64, v: f64, dt: f64) f64 {
    return x + v * dt;
}

pub fn gromacs_vrescale_lambda(ek_new: f64, ek: f64) f64 {
    return std.math.sqrt(ek_new / ek);
}

pub fn gromacs_pbc_wrap(x: f64, inv_box: f64) f64 {
    const shift = @floor(x * inv_box);
    return x - shift / inv_box;
}

pub fn gromacs_halo_buffer_size(num: u32) u32 {
    return num + 1;
}

pub fn gromacs_fudge_qq(raw_qq: f64, fudge: f64) f64 {
    return raw_qq * fudge;
}

pub fn gromacs_spring_force(k: f64, dev: f64) f64 {
    return -k * dev;
}

// --- Foldseek ---

pub fn foldseek_cbeta_geometry(u_1: f64, u_2: f64) f64 {
    return -0.333333 * u_1 + 0.5 * u_2;
}

pub fn foldseek_lddt_inclusion(distance: f64, row: u32, col: u32) u8 {
    if (distance < 15.0 and col != row) {
        return 1;
    }
    return 0;
}

pub fn foldseek_tm_filter(i: i32, d: f64, score_d8: f64) u8 {
    if (i >= 0 or d <= score_d8) {
        return 1;
    }
    return 0;
}

pub fn foldseek_gap_penalty_sat(vH: u8, vGapO: u8) u8 {
    if (vH < vGapO) {
        return 0;
    }
    return vH - vGapO;
}

pub fn foldseek_bfactor_mask(bfactor: f64, threshold: f64) u8 {
    if (bfactor < threshold) {
        return 1;
    }
    return 0;
}

pub fn foldseek_evalue_mu(nn_out: f64) f64 {
    return nn_out * 0.175 + 0.5;
}

// --- RAxML ---

pub fn raxml_freq_invalid(base_freq: f64) u8 {
    if (base_freq < 0.0 or base_freq >= 1.0) {
        return 1;
    }
    return 0;
}

pub fn raxml_rate_normalize(rate: f64, ref_rate: f64) f64 {
    return rate / ref_rate;
}

pub fn raxml_branch_clamp(length_in: f64, min_len: f64, max_len: f64) f64 {
    var length = length_in;
    if (length < min_len) {
        length = min_len;
    }
    if (length > max_len) {
        length = max_len;
    }
    return length;
}

pub fn raxml_improvement_check(new_score: f64, old_score: f64, epsilon: f64) u8 {
    if (new_score - old_score > epsilon) {
        return 1;
    }
    return 0;
}

pub fn raxml_tie_break(p1: f64, p2: f64) u8 {
    if (p1 > p2) {
        return 1;
    }
    return 0;
}

pub fn raxml_split_conflict(is_compatible: u8) u8 {
    if (is_compatible == 0) {
        return 1;
    }
    return 0;
}

// --- IQ-TREE ---

pub fn iqtree_bootstrap_replace(replace_flag: u8) u8 {
    if (replace_flag == 1) {
        return 1;
    }
    return 0;
}

pub fn iqtree_underflow_scale(likelihood: f64, threshold: f64) f64 {
    if (likelihood < threshold and likelihood > 0.0) {
        return threshold;
    }
    return likelihood;
}

pub fn iqtree_align_offset(addr: u64, mask: u64) u64 {
    return addr & mask;
}

pub fn iqtree_nni_symmetric_update(a_in: u32, b_in: u32, symmetric: u8) u32 {
    var a = a_in;
    var b = b_in;
    if (symmetric == 1) {
        a = a ^ b;
        b = a ^ b;
        a = a ^ b;
    }
    return a * 100 + b;
}

pub fn iqtree_branch_clamp(length_in: f64) f64 {
    var length = length_in;
    if (length <= 0.0) {
        length = 1e-6;
    }
    return length;
}

pub fn iqtree_weight_normalize(weight: f64, sum: f64) f64 {
    return weight / sum;
}
