#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdlib.h>

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
    *sp = 0;
    *ep = (uint32_t)(bwt_len - 1);
    int32_t i = (int32_t)(pat_len - 1);
    while (*sp <= *ep && i >= 0) {
        uint8_t c = pattern[i];
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

uint32_t get_lca(uint32_t u, uint32_t v, const TreeNode* tree) {
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
