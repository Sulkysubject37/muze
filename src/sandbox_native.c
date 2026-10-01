#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>

// IPC Binary Structs (The ABI)
#pragma pack(push, 1)
typedef struct {
    uint32_t magic_seed; // Deterministic state injection (e.g., 0x5BD1E995)
    uint8_t domain_id;   // 1=Genomics, 2=Transcriptomics, etc.
    double payload_f64_1;
    double payload_f64_2;
    uint64_t payload_u64;
} MuzeIpcPacket;
#pragma pack(pop)

// Native C Biological Sandbox
void bwt_backward_search(const uint8_t* pattern, size_t pat_len, 
                         const uint32_t* count_table, 
                         const uint32_t* occ_table, size_t bwt_len,
                         uint32_t* sp, uint32_t* ep) {
    if (bwt_len == 0) { *sp = 0; *ep = 0; return; }
    *sp = 0;
    *ep = (uint32_t)(bwt_len - 1);
    int32_t i = (int32_t)(pat_len - 1);
    while (*sp <= *ep && i >= 0) {
        uint8_t c = (pattern[i] >> 1) & 3;
        uint32_t occ_sp = (*sp == 0) ? 0 : occ_table[(*sp - 1) * 4 + c];
        *sp = count_table[c] + occ_sp;
        *ep = count_table[c] + occ_table[*ep * 4 + c] - 1;
        i--;
    }
}

uint64_t encode_kmer(const char* seq, size_t k) {
    uint64_t kmer = 0;
    for (size_t i = 0; i < k; i++) {
        uint64_t val = (seq[i] >> 1) & 3; 
        kmer = (kmer << 2) | val;
    }
    return kmer;
}

uint64_t reverse_complement(uint64_t kmer, size_t k) {
    uint64_t rc = 0;
    for (size_t i = 0; i < k; i++) {
        uint64_t base = (kmer >> (2 * i)) & 3;
        rc = (rc << 2) | ((~base) & 3);
    }
    return rc;
}

uint64_t get_canonical_kmer(uint64_t kmer, size_t k) {
    uint64_t rc = reverse_complement(kmer, k);
    return (kmer < rc) ? kmer : rc;
}

typedef struct {
    uint32_t parent;
    uint32_t depth;
} TreeNode;

uint32_t get_lca(uint32_t u_in, uint32_t v_in, const TreeNode* tree) {
    uint32_t u = u_in, v = v_in;
    if (u == 0 || v == 0) return (u != 0) ? u : v;
    while (u != v) {
        if (u > v) u = tree[u].parent;
        else       v = tree[v].parent;
    }
    return u;
}

double lennard_jones_potential(const double* pos_x, const double* pos_y, const double* pos_z, 
                               size_t num_particles, double box_size, double cutoff) {
    double total_energy = 0.0;
    double cutoff_sq = cutoff * cutoff;
    for (size_t i = 0; i < num_particles; i++) {
        for (size_t j = i + 1; j < num_particles; j++) {
            double dx = pos_x[i] - pos_x[j];
            double dy = pos_y[i] - pos_y[j];
            double dz = pos_z[i] - pos_z[j];
            dx -= box_size * (long)(dx / box_size);
            dy -= box_size * (long)(dy / box_size);
            dz -= box_size * (long)(dz / box_size);
            double r2 = dx*dx + dy*dy + dz*dz;
            if (r2 < cutoff_sq) {
                double r6 = r2 * r2 * r2;
                double r12 = r6 * r6;
                total_energy += 4.0 * ((1.0 / r12) - (1.0 / r6));
            }
        }
    }
    return total_energy;
}

uint64_t sliding_window_minimizer(const char* seq, size_t seq_len, size_t k, size_t w) {
    uint64_t min_hash = UINT64_MAX;
    for (size_t i = 0; i <= seq_len - w; i++) {
        for (size_t j = 0; j <= w - k; j++) {
            uint64_t kmer = encode_kmer(seq + i + j, k);
            uint64_t canonical = get_canonical_kmer(kmer, k);
            uint64_t hash = canonical ^ 0x5bd1e995;
            hash ^= hash >> 15;
            if (hash < min_hash) {
                min_hash = hash;
            }
        }
    }
    return min_hash;
}
// --- Parity additions: Kraken2 / Jellyfish functions ---

uint32_t kraken2_translate(size_t seq_len) {
    uint32_t total_frames = 0;
    for (size_t i = 0; i < seq_len; i++)
        total_frames += (uint32_t)(i % 3);
    return total_frames;
}

bool kraken2_mask(uint32_t cv, uint32_t threshold) {
    return (cv * 10 > threshold * 2);
}

uint64_t jellyfish_canonical_kmer(uint64_t kmer_in) {
    uint64_t rc = ~kmer_in;
    return (rc < kmer_in) ? rc : kmer_in;
}

uint64_t jellyfish_bloom_filter(uint64_t hash_val) {
    uint64_t pos = hash_val;
    for (int i = 0; i < 3; i++) pos = (pos * 17) % 1024;
    return pos;
}

uint64_t jellyfish_cas_counter(uint64_t val) {
    uint64_t count = val;
    if (count < 255) count += 1;
    return count;
}

// --- Kallisto ---

uint32_t kallisto_ec_intersect(uint32_t read_set, uint32_t ec_set) {
    uint32_t result = 0;
    for (int i = 0; i < 32; i++) {
        uint32_t mask = 1u << i;
        if ((read_set & mask) != 0 && (ec_set & mask) != 0) {
            result |= mask;
        }
    }
    return result;
}

double kallisto_em_noise_truncate(double prob, double noise_limit) {
    if (prob < noise_limit) {
        return 0.0;
    }
    return prob;
}

double kallisto_effective_length_normalize(double count, double eff_len) {
    if (eff_len < 1.0) {
        eff_len = 1.0;
    }
    return count / eff_len;
}

uint8_t kallisto_kmer_odd_constraint(uint32_t k) {
    if (k % 2 != 0 && k >= 3) {
        return 1;
    }
    return 0;
}

uint32_t kallisto_strand_flip(uint32_t pos, uint8_t forward) {
    uint32_t packed = pos & 0x7FFFFFFF;
    if (!forward) {
        packed |= 0x80000000;
    }
    return packed;
}

uint8_t kallisto_umi_match(uint32_t dist, uint32_t threshold) {
    if (dist <= threshold) {
        return 1;
    }
    return 0;
}

// --- SAMtools ---

uint8_t samtools_bed_overlap(uint32_t pos, uint32_t beg, uint32_t end) {
    if (pos >= beg && pos < end) {
        return 1;
    }
    return 0;
}

uint32_t samtools_vcf_coordinate(uint32_t pos) {
    return pos + 1;
}

uint8_t samtools_is_reverse(uint32_t flag) {
    if ((flag & 0x10) != 0) {
        return 1;
    }
    return 0;
}

uint8_t samtools_iupac_match(uint8_t c1, uint8_t c2) {
    if (c1 == c2 && c2 != 15) {
        return 1;
    }
    return 0;
}

uint32_t samtools_unclipped_pos(uint32_t pos, uint32_t clip_len, uint8_t use_unclipped) {
    if (use_unclipped) {
        return pos - clip_len;
    }
    return pos;
}

uint8_t samtools_proper_pair(uint32_t flag1, uint32_t flag2) {
    if ((flag1 & 0x10) == 0 && (flag2 & 0x10) != 0) {
        return 1;
    }
    return 0;
}

// --- BWA ---

uint32_t bwa_sentinel_shift(uint32_t k, uint32_t primary) {
    if (k >= primary) {
        k -= 1;
    }
    return k;
}

uint8_t bwa_n_filter(uint8_t base_code) {
    if (base_code < 4) {
        return 1;
    }
    return 0;
}

uint32_t bwa_gap_penalty(uint32_t q, uint32_t r, uint32_t n_ext) {
    return q + r * n_ext;
}

uint8_t bwa_simd_saturated(uint32_t gmax, uint32_t shift) {
    if (gmax + shift >= 255 || gmax >= 255) {
        return 1;
    }
    return 0;
}

uint8_t bwa_chain_gap_valid(uint32_t x, uint32_t bw) {
    if (x <= bw) {
        return 1;
    }
    return 0;
}

uint32_t bwa_pair_strand_code(uint32_t r1, uint32_t r2) {
    return r1 ^ r2;
}

double bwa_insert_lower_bound(double p25, double p75, double bound) {
    return p25 - bound * (p75 - p25);
}

// --- Salmon ---

uint32_t salmon_rc_index(uint32_t idx, uint32_t seq_len) {
    return seq_len - 1 - idx;
}

uint8_t salmon_ec_filter(uint8_t is_compat) {
    if (is_compat == 1) {
        return 1;
    }
    return 0;
}

uint8_t salmon_em_converged(double alpha, double cutoff) {
    if (alpha > cutoff) {
        return 1;
    }
    return 0;
}

uint32_t salmon_rad_pack(uint32_t tid, uint32_t ori_fw) {
    return tid | (ori_fw << 1);
}

uint8_t salmon_mask_base(uint8_t base) {
    if (base >= 65 && base <= 84) {
        return base;
    }
    return 78;
}

uint8_t salmon_cigar_state(uint8_t op) {
    if (op == 1) {
        return 3;
    }
    return op;
}

// --- GROMACS ---

double gromacs_leapfrog_step(double x, double v, double dt) {
    return x + v * dt;
}

double gromacs_vrescale_lambda(double ek_new, double ek) {
    return sqrt(ek_new / ek);
}

double gromacs_pbc_wrap(double x, double inv_box) {
    double shift = floor(x * inv_box);
    return x - shift / inv_box;
}

uint32_t gromacs_halo_buffer_size(uint32_t num) {
    return num + 1;
}

double gromacs_fudge_qq(double raw_qq, double fudge) {
    return raw_qq * fudge;
}

double gromacs_spring_force(double k, double dev) {
    return -k * dev;
}

// --- Foldseek ---

double foldseek_cbeta_geometry(double u1, double u2) {
    return -0.333333 * u1 + 0.5 * u2;
}

uint8_t foldseek_lddt_inclusion(double distance, uint32_t row, uint32_t col) {
    if (distance < 15.0 && col != row) {
        return 1;
    }
    return 0;
}

uint8_t foldseek_tm_filter(int32_t i, double d, double score_d8) {
    if (i >= 0 || d <= score_d8) {
        return 1;
    }
    return 0;
}

uint8_t foldseek_gap_penalty_sat(uint8_t vH, uint8_t vGapO) {
    if (vH < vGapO) {
        return 0;
    }
    return vH - vGapO;
}

uint8_t foldseek_bfactor_mask(double bfactor, double threshold) {
    if (bfactor < threshold) {
        return 1;
    }
    return 0;
}

double foldseek_evalue_mu(double nn_out) {
    return nn_out * 0.175 + 0.5;
}

// --- RAxML ---

uint8_t raxml_freq_invalid(double base_freq) {
    if (base_freq < 0.0 || base_freq >= 1.0) {
        return 1;
    }
    return 0;
}

double raxml_rate_normalize(double rate, double ref_rate) {
    return rate / ref_rate;
}

double raxml_branch_clamp(double length_in, double min_len, double max_len) {
    double length = length_in;
    if (length < min_len) {
        length = min_len;
    }
    if (length > max_len) {
        length = max_len;
    }
    return length;
}

uint8_t raxml_improvement_check(double new_score, double old_score, double epsilon) {
    if (new_score - old_score > epsilon) {
        return 1;
    }
    return 0;
}

uint8_t raxml_tie_break(double p1, double p2) {
    if (p1 > p2) {
        return 1;
    }
    return 0;
}

uint8_t raxml_split_conflict(uint8_t is_compatible) {
    if (is_compatible == 0) {
        return 1;
    }
    return 0;
}

// --- IQ-TREE ---

uint8_t iqtree_bootstrap_replace(uint8_t replace_flag) {
    if (replace_flag == 1) {
        return 1;
    }
    return 0;
}

double iqtree_underflow_scale(double likelihood, double threshold) {
    if (likelihood < threshold && likelihood > 0.0) {
        return threshold;
    }
    return likelihood;
}

uint64_t iqtree_align_offset(uint64_t addr, uint64_t mask) {
    return addr & mask;
}

uint32_t iqtree_nni_symmetric_update(uint32_t a_in, uint32_t b_in, uint8_t symmetric) {
    uint32_t a = a_in;
    uint32_t b = b_in;
    if (symmetric == 1) {
        a = a ^ b;
        b = a ^ b;
        a = a ^ b;
    }
    return a * 100 + b;
}

double iqtree_branch_clamp(double length_in) {
    double length = length_in;
    if (length <= 0.0) {
        length = 1e-6;
    }
    return length;
}

double iqtree_weight_normalize(double weight, double sum) {
    return weight / sum;
}

// --- IPC entry point ---

static int read_exact(void* buf, size_t n) {
    size_t got = 0; uint8_t* p = (uint8_t*)buf;
    while (got < n) {
        ssize_t r = read(0, p + got, n - got);
        if (r <= 0) return -1;
        got += (size_t)r;
    }
    return 0;
}

static int write_exact(const void* buf, size_t n) {
    size_t sent = 0; const uint8_t* p = (const uint8_t*)buf;
    while (sent < n) {
        ssize_t w = write(1, p + sent, n - sent);
        if (w <= 0) return -1;
        sent += (size_t)w;
    }
    return 0;
}

int main(void) {
    MuzeIpcPacket packet;
    if (read_exact(&packet, sizeof(packet)) != 0) return 0;
    if (packet.magic_seed != 0x5BD1E995) return 0;

    static const TreeNode tree[5] = {
        {0,0},{0,1},{0,1},{1,2},{1,2}
    };

    switch (packet.domain_id) {
        case 1: {
            static const uint32_t count_table[4] = {0,1,2,3};
            static const uint32_t occ_table[16]  = {0}; // bwt_len * 4
            uint32_t sp = 0, ep = 0;
            const uint8_t pattern[4] = {'A','C','G','T'};
            bwt_backward_search(pattern, 4, count_table, occ_table, 4, &sp, &ep);
            packet.payload_u64 = sp;
            break;
        }
        case 2:  packet.payload_u64 = sliding_window_minimizer("ACGTAACCGGTT", 12, 4, 8); break;
        case 3:  packet.payload_u64 = get_lca(3, 4, tree); break;
        case 4: {
            const double px[2] = {0.0, 1.2};
            const double py[2] = {0.0, 0.0};
            const double pz[2] = {0.0, 0.0};
            packet.payload_f64_1 = lennard_jones_potential(px, py, pz, 2, 10.0, 2.0);
            break;
        }
        case 5:  packet.payload_u64 = get_canonical_kmer(encode_kmer("ACGT", 4), 4); break;
case 6:  packet.payload_u64 = get_lca(3, 4, tree); break;
        case 7:  packet.payload_u64 = kraken2_translate(12); break;
        case 8:  packet.payload_u64 = kraken2_mask(5, 20) ? 1 : 0; break;
        case 9:  packet.payload_u64 = jellyfish_canonical_kmer(packet.payload_u64); break;
        case 10: packet.payload_u64 = jellyfish_bloom_filter(packet.payload_u64); break;
        case 11: packet.payload_u64 = jellyfish_cas_counter(packet.payload_u64); break;
        case 12: {
            packet.payload_u64 = kallisto_ec_intersect(0xF0F0u, 0xAAAAu);
            break;
        }
        case 13: {
            packet.payload_f64_1 = kallisto_em_noise_truncate(0.05, 0.05);
            break;
        }
        case 14: {
            packet.payload_f64_1 = kallisto_effective_length_normalize(100.0, 0.5);
            break;
        }
        case 15: {
            packet.payload_u64 = kallisto_kmer_odd_constraint(31);
            break;
        }
        case 16: {
            packet.payload_u64 = kallisto_strand_flip(0x12345678u, 0);
            break;
        }
        case 17: {
            packet.payload_u64 = kallisto_umi_match(1, 1);
            break;
        }
        case 18: {
            packet.payload_u64 = samtools_bed_overlap(5, 0, 5);
            break;
        }
        case 19: {
            packet.payload_u64 = samtools_vcf_coordinate(100);
            break;
        }
        case 20: {
            packet.payload_u64 = samtools_is_reverse(0);
            break;
        }
        case 21: {
            packet.payload_u64 = samtools_iupac_match(15, 15);
            break;
        }
        case 22: {
            packet.payload_u64 = samtools_unclipped_pos(100, 10, 1);
            break;
        }
        case 23: {
            packet.payload_u64 = samtools_proper_pair(0, 0);
            break;
        }
        case 24: {
            packet.payload_u64 = bwa_sentinel_shift(5, 5);
            break;
        }
        case 25: {
            packet.payload_u64 = bwa_n_filter(4);
            break;
        }
        case 26: {
            packet.payload_u64 = bwa_gap_penalty(5, 2, 3);
            break;
        }
        case 27: {
            packet.payload_u64 = bwa_simd_saturated(250, 5);
            break;
        }
        case 28: {
            packet.payload_u64 = bwa_chain_gap_valid(10, 10);
            break;
        }
        case 29: {
            packet.payload_u64 = bwa_pair_strand_code(1, 3);
            break;
        }
        case 30: {
            packet.payload_f64_1 = bwa_insert_lower_bound(100.0, 200.0, 1.5);
            break;
        }
        case 31: {
            packet.payload_u64 = salmon_rc_index(2, 10);
            break;
        }
        case 32: {
            packet.payload_u64 = salmon_ec_filter(1);
            break;
        }
        case 33: {
            packet.payload_u64 = salmon_em_converged(0.05, 0.05);
            break;
        }
        case 34: {
            packet.payload_u64 = salmon_rad_pack(3, 1);
            break;
        }
        case 35: {
            packet.payload_u64 = salmon_mask_base(88);
            break;
        }
        case 36: {
            packet.payload_u64 = salmon_cigar_state(1);
            break;
        }
        case 37: {
            packet.payload_f64_1 = gromacs_leapfrog_step(1.0, 2.0, 0.5);
            break;
        }
        case 38: {
            packet.payload_f64_1 = gromacs_vrescale_lambda(1.0, 4.0);
            break;
        }
        case 39: {
            packet.payload_f64_1 = gromacs_pbc_wrap(5.5, 0.1);
            break;
        }
        case 40: {
            packet.payload_u64 = gromacs_halo_buffer_size(8);
            break;
        }
        case 41: {
            packet.payload_f64_1 = gromacs_fudge_qq(10.0, 0.5);
            break;
        }
        case 42: {
            packet.payload_f64_1 = gromacs_spring_force(2.0, 3.0);
            break;
        }
        case 43: {
            packet.payload_f64_1 = foldseek_cbeta_geometry(1.0, 2.0);
            break;
        }
        case 44: {
            packet.payload_u64 = foldseek_lddt_inclusion(10.0, 3, 5);
            break;
        }
        case 45: {
            packet.payload_u64 = foldseek_tm_filter(-1, 20.0, 4.0);
            break;
        }
        case 46: {
            packet.payload_u64 = foldseek_gap_penalty_sat(10, 20);
            break;
        }
        case 47: {
            packet.payload_u64 = foldseek_bfactor_mask(50.0, 70.0);
            break;
        }
        case 48: {
            packet.payload_f64_1 = foldseek_evalue_mu(2.0);
            break;
        }
        case 49: {
            packet.payload_u64 = raxml_freq_invalid(1.0);
            break;
        }
        case 50: {
            packet.payload_f64_1 = raxml_rate_normalize(10.0, 2.0);
            break;
        }
        case 51: {
            packet.payload_f64_1 = raxml_branch_clamp(5.0, 0.0, 10.0);
            break;
        }
        case 52: {
            packet.payload_u64 = raxml_improvement_check(5.0, 4.0, 1.0);
            break;
        }
        case 53: {
            packet.payload_u64 = raxml_tie_break(5.0, 5.0);
            break;
        }
        case 54: {
            packet.payload_u64 = raxml_split_conflict(0);
            break;
        }
        case 55: {
            packet.payload_u64 = iqtree_bootstrap_replace(1);
            break;
        }
        case 56: {
            packet.payload_f64_1 = iqtree_underflow_scale(0.5, 0.01);
            break;
        }
        case 57: {
            packet.payload_u64 = iqtree_align_offset(0xFFu, 0x0Fu);
            break;
        }
        case 58: {
            packet.payload_u64 = iqtree_nni_symmetric_update(3, 7, 1);
            break;
        }
        case 59: {
            packet.payload_f64_1 = iqtree_branch_clamp(0.0);
            break;
        }
        case 60: {
            packet.payload_f64_1 = iqtree_weight_normalize(0.3, 3.0);
            break;
        }
        default: return 0;
    }

    write_exact(&packet, sizeof(packet));
    return 0;
}
