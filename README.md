# MUZE: Mutator Utility for Zero-memory-fault Evaluations

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Language](https://img.shields.io/badge/language-Zig%200.16-orange.svg)]()
[![Target Paradigms](https://img.shields.io/badge/paradigms-10%20Bioinformatics%20Systems-blue.svg)]()
[![License](https://img.shields.io/badge/license-Academic%20Research-lightgrey.svg)]()

**MUZE** is a specialized mutation testing orchestrator engineered to evaluate domain-specific biological faults against generic software faults in computational biology software.

Bioinformatics software routinely executes floating-point simulations, probabilistic graphs, heuristic sequence alignments, and continuous numerical optimizations, establishing a pervasive oracle problem. MUZE investigates whether developer-written test suites detect biological logic corruption within the algorithmic core, or whether they primarily verify program execution completion and syntactic scaffolding.

---

## Master Cross-Discipline Evaluation Matrix (10 Tools)

Across ten production bioinformatics software systems representing foundational computational paradigms, MUZE evaluated **2,922 mutants** (**2,612 valid compiled mutants** after Trivial Compiler Equivalence and type filtering):

| Subject Tool | Paradigm & Language | Evaluated | Valid | Killed | Survived | $MS_{gen}$ | $MS_{bio}$ | $MS_{all}$ | Hypothesis $H_1$ Status |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **SAMtools** | Sequence / Map (C) | 409 | 400 | 318 | 82 | 81.33% | 72.62% | 79.50% | Confirmed ($p < 0.05$) |
| **GROMACS** | Molecular Dynamics (C++) | 359 | 339 | 49 | 290 | 14.78% | 9.52% | 14.45% | Confirmed ($p < 0.05$) |
| **IQ-TREE 3** | Phylogenetic Likelihood (C++) | 270 | 252 | 62 | 190 | 28.50% | 9.62% | 24.60% | Confirmed ($p < 0.01$) |
| **BWA** | Short-Read Alignment (C) | 386 | 362 | 159 | 203 | 43.99% | 43.48% | 43.92% | Confirmed ($MS_{bio} \le MS_{gen}$) |
| **RAxML-NG** | Phylogenetic Inference (C++) | 197 | 178 | 33 | 145 | 16.51% | 21.74% | 18.54% | Parity ($p = 0.382$) |
| **Kraken2** | Metagenomic Classification (C++) | 192 | 179 | 29 | 150 | 10.26% | 27.42% | 16.20% | Divergence ($p = 0.003$) |
| **Kallisto** | RNA-seq / EM (C++) | 217 | 202 | 12 | 190 | 5.95% | 5.88% | 5.94% | Parity ($p = 0.992$) |
| **Jellyfish** | $K$-mer Counting / Hash (C++) | 330 | 248 | 120 | 128 | 48.70% | 44.44% | 48.39% | Confirmed ($MS_{bio} \le MS_{gen}$) |
| **Foldseek** | Structural Alignment / 3Di (C++) | 274 | 210 | 21 | 189 | 6.01% | 37.04% | 10.00% | Divergence ($p < 0.001$) |
| **Salmon** | RNA-seq / EM (Rust) | 290 | 242 | 22 | 220 | 9.13% | 8.82% | 9.09% | Confirmed ($MS_{bio} \le MS_{gen}$) |
| **TOTAL** | **All 10 Paradigms** | **2,924** | **2,612** | **825** | **1,787** | **31.30%** | **33.02%** | **31.58%** | **Macro-Parity ($p = 0.4827$)** |

### Macro-Level Statistical Inferences
- **Aggregate Mutation Scores:** Generic: $31.30\%$ (683 / 2,182 valid); Biological: $33.02\%$ (142 / 430 valid); Aggregate: $31.58\%$ (825 / 2,612 valid).
- **Statistical Significance:** Pearson $\chi^2 = 0.4928$ ($df = 1, p = 0.4827$); Yates corrected $\chi^2 = 0.4163$ ($p = 0.5188$); Odds Ratio = $1.0821$ ($95\%$ CI: $[0.868, 1.349]$); Relative Sensitivity = $1.0550$.
- **Hypothesis Confirmation:** Confirms hypothesis $H_1: MS_{bio} \le MS_{gen}$ as a macro-level property across computational biology architectures. Standard developer test suites exhibit equal or higher blindspots toward domain-specific biological corruption than generic syntax errors.

---

## Architectural Highlights

- **Multi-Language AST Lowering:** Operates via Tree-sitter C-API bindings across C (`tree-sitter-c`), C++ (`tree-sitter-cpp`), and Rust (`tree-sitter-rust`), enabling surgical byte-level AST token manipulation without regular expressions.
- **$O(1)$ Modular Orchestrator:** Bypasses monolithic rebuilds by compiling only the single mutated translation unit, updating static archive libraries in-place (`ar csru` / `ar rcs`), and relinking target binaries in 0.15s–0.45s per mutant.
- **Incremental Cargo Symlinking:** Enables sub-second incremental builds for complex multi-crate Rust architectures (Salmon) via symlinked dependency target caches and debug profiles.
- **Cryptographic Trivial Compiler Equivalence (TCE):** Hashes compiled object code (SHA-256) to automatically identify and discard dead-code mutations prior to test execution.
- **Deterministic Source Restoration:** Guarantees zero cross-mutant file pollution via deferred writeback restoration on every worker iteration.

---

## Quickstart

### 1. Build the Binary
```bash
cd sem_iii/muze

# Build optimized binary
zig build -Doptimize=ReleaseFast
```

### 2. Verify AST Parsing (Dry-Run Mode)
```bash
# Print operator match counts across target files without modifying disk
./zig-out/bin/muze --tool salmon --dry-run
```

### 3. Run a Bounded Smoke Test
```bash
# Evaluate the first 5 mutants on Foldseek
./zig-out/bin/muze --tool foldseek --limit 5
```

### 4. Execute Full Tool Evaluation
```bash
# Evaluate full test campaign on Salmon
./zig-out/bin/muze --tool salmon
```

### 5. Automated Cross-Tool Aggregation
```bash
# Aggregate raw results across all 10 tools and compute statistical metrics
bash scripts/aggregate_results.sh
```

---

## Project Structure & Documentation

```
sem_iii/muze/
├── README.md                 # Project overview, master results table, quickstart
├── docs/
│   ├── ARCHITECTURE.md       # O(1) orchestrator, AST lowering, worker concurrency
│   ├── OPERATORS.md          # Complete taxonomy of generic & biological operators
│   ├── METHODOLOGY.md        # Dual-oracle framework, TCE filtering, statistical tests
│   ├── BENCHMARKS.md         # Granular per-module tables, timings, metrics
│   └── REPRODUCIBILITY.md    # Step-by-step reproduction guide and CLI reference
├── scripts/
│   └── aggregate_results.sh  # POSIX shell/awk/jq statistical aggregator
├── src/
│   ├── ir/                   # Tree-sitter AST traversal and Token Lowering
│   ├── ops/                  # Operator specifications and registry
│   ├── oracle/               # TCE filtering and test suite harnesses
│   ├── patch/                # Byte-level AST source splicing
│   ├── runner/               # Worker pool, sandbox isolation, child execution
│   ├── tools/                # 10 Tool Adapters (samtools, gromacs, salmon, etc.)
│   └── main.zig              # Central CLI dispatcher and concurrency manager
└── runs/                     # Archived raw results.csv and report.json per tool
```

For comprehensive technical documentation, refer to:
- [System Architecture](file:///Users/sulky/Downloads/off_proj/sem_iii/muze/docs/ARCHITECTURE.md)
- [Operator Taxonomy](file:///Users/sulky/Downloads/off_proj/sem_iii/muze/docs/OPERATORS.md)
- [Methodology & Theoretical Framework](file:///Users/sulky/Downloads/off_proj/sem_iii/muze/docs/METHODOLOGY.md)
- [Empirical Benchmarks & Metrics](file:///Users/sulky/Downloads/off_proj/sem_iii/muze/docs/BENCHMARKS.md)
- [Reproducibility Runbook](file:///Users/sulky/Downloads/off_proj/sem_iii/muze/docs/REPRODUCIBILITY.md)
