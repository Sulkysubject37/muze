# Reproducibility Guide & Execution Runbook

## 1. System Requirements

The MUZE framework is developed natively in Zig and interfaces directly with C, C++, and Rust build chains:

- **Operating System:** macOS (ARM64 Apple Silicon or x86_64) or Linux (Ubuntu 22.04+ / Debian).
- **Core Compilers & Toolchains:**
  - **Zig:** `0.16.x` or compatible development build.
  - **C/C++ Compilers:** `clang`/`clang++` (LLVM 15+) or `gcc`/`g++` (GCC 11+).
  - **Rust Toolchain:** `rustc 1.80+` and `cargo` (verified with `1.99.1`).
- **Standard Utilities:** `awk`, `sed`, `grep`, `jq`, `ar`, `make`, `cmake`.

---

## 2. Building the Framework

Compile the standalone `muze` binary from the repository root:

```bash
cd sem_iii/muze

# Compile optimized executable into zig-out/bin/muze
zig build -Doptimize=ReleaseFast
```

The resulting binary is located at `./zig-out/bin/muze`.

---

## 3. CLI Command Options

The `muze` runner supports the following operational flags:

```bash
./zig-out/bin/muze --tool <name> [--limit <N>] [--dry-run]
```

- `--tool <name>`: Target bioinformatics subject. Supported tool names:
  `samtools`, `gromacs`, `iqtree`, `bwa`, `raxml`, `kraken2`, `kallisto`, `jellyfish`, `foldseek`, `salmon`.
- `--dry-run`: Scans target AST files, extracts matches, and prints a complete breakdown of generic and domain biological operators without modifying files or executing tests.
- `--limit <N>`: Bounds mutant evaluation to the first $N$ candidates (ideal for fast smoke-testing).

---

## 4. Verification and Smoke Testing

Before executing full evaluation runs, dry-run parsing and bounded smoke tests should be executed to confirm toolchain alignment:

```bash
# 1. Verify AST parsing and operator calibration (e.g., Salmon)
./zig-out/bin/muze --tool salmon --dry-run

# 2. Run a 5-mutant verification smoke test
./zig-out/bin/muze --tool salmon --limit 5

# 3. Verify Foldseek structural alignment adapter
./zig-out/bin/muze --tool foldseek --limit 5
```

---

## 5. Executing the 10-Tool Empirical Evaluation

To reproduce the empirical datasets, execute `muze` sequentially or concurrently across the ten tools:

```bash
# 1. SAMtools (Sequence / Map processing)
./zig-out/bin/muze --tool samtools

# 2. GROMACS (Molecular Dynamics simulation)
./zig-out/bin/muze --tool gromacs

# 3. IQ-TREE 3 (Phylogenetic Likelihood)
./zig-out/bin/muze --tool iqtree

# 4. BWA (Burrows-Wheeler short-read alignment)
./zig-out/bin/muze --tool bwa

# 5. RAxML-NG (Phylogenetic tree inference)
./zig-out/bin/muze --tool raxml

# 6. Kraken2 (Taxonomic sequence classification)
./zig-out/bin/muze --tool kraken2

# 7. Kallisto (RNA-seq pseudoalignment)
./zig-out/bin/muze --tool kallisto

# 8. Jellyfish (Lock-free concurrent k-mer hashing)
./zig-out/bin/muze --tool jellyfish

# 9. Foldseek (3Di macromolecular structural alignment)
./zig-out/bin/muze --tool foldseek

# 10. Salmon (Expectation-Maximization transcript quantification in Rust)
./zig-out/bin/muze --tool salmon
```

---

## 6. Output Artifacts and Data Validation

Each run writes standardized output files into `runs/<tool>/`:
- `results.csv`: Tabular record of every evaluated mutant, containing mutant ID, source file, character replacement, mutant class (`aor`, `lcr`, `log`, `bit`, `bio`), compilation outcome, test exit code, and oracle verdict (`killed`, `survived`, `invalid`, `timeout`).
- `report.json`: Machine-readable summary struct recording total counts, kill counts, survival counts, invalid counts, and per-mutant metadata.
- `report.md`: Markdown summary report displaying per-operator mutation scores and contingency metrics.

### Automated Cross-Tool Aggregation

To recompute all cross-discipline metrics, chi-squared tests, odds ratios, and summary tables from the raw JSON reports, execute the POSIX aggregation script:

```bash
# Execute data aggregation across all archived reports
bash scripts/aggregate_results.sh
```
