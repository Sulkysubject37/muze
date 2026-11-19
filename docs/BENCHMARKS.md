# Empirical Benchmarks and Statistical Records

## 1. Master Cross-Discipline Evaluation Matrix (10 Tools)

The empirical campaign encompasses ten production bioinformatics software systems representing foundational computational paradigms:

| Subject Tool | Paradigm & Language | Evaluated | Valid | Killed | Survived | Invalid | $MS_{gen}$ | $MS_{bio}$ | $MS_{all}$ | Hypothesis $H_1$ Status |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **SAMtools** | Sequence / Map (C) | 407 | 400 | 318 | 82 | 7 | 81.33% | 72.62% | 79.50% | Confirmed ($p < 0.05$) |
| **GROMACS** | Molecular Dynamics (C++) | 359 | 339 | 49 | 290 | 20 | 14.78% | 9.52% | 14.45% | Confirmed ($p < 0.05$) |
| **IQ-TREE 3** | Phylogenetic Likelihood (C++) | 270 | 252 | 62 | 190 | 18 | 28.50% | 9.62% | 24.60% | Confirmed ($p < 0.01$) |
| **BWA** | Short-Read Alignment (C) | 386 | 362 | 159 | 203 | 24 | 43.99% | 43.48% | 43.92% | Confirmed ($MS_{bio} \le MS_{gen}$) |
| **RAxML-NG** | Phylogenetic Inference (C++) | 197 | 178 | 33 | 145 | 19 | 16.51% | 21.74% | 18.54% | Parity ($p = 0.382$) |
| **Kraken2** | Metagenomic Classification (C++) | 192 | 179 | 29 | 150 | 13 | 10.26% | 27.42% | 16.20% | Divergence ($p = 0.003$) |
| **Kallisto** | RNA-seq / EM (C++) | 217 | 202 | 12 | 190 | 15 | 5.95% | 5.88% | 5.94% | Parity ($p = 0.992$) |
| **Jellyfish** | $K$-mer Counting / Hash (C++) | 330 | 248 | 120 | 128 | 82 | 48.70% | 44.44% | 48.39% | Confirmed ($MS_{bio} \le MS_{gen}$) |
| **Foldseek** | Structural Alignment / 3Di (C++) | 274 | 210 | 21 | 189 | 64 | 6.01% | 37.04% | 10.00% | Divergence ($p < 0.001$) |
| **Salmon** | RNA-seq / EM (Rust) | 290 | 242 | 22 | 220 | 48 | 9.13% | 8.82% | 9.09% | Confirmed ($MS_{bio} \le MS_{gen}$) |
| **Total** | **All 10 Paradigms** | **2,922** | **2,612** | **825** | **1,787** | **310** | **31.30%** | **33.02%** | **31.58%** | **Macro-Parity ($p = 0.4827$)** |

---

## 2. Macro-Level Statistical Aggregate

- **Total Mutants Evaluated:** 2,922
- **Valid Compiled Mutants:** 2,612
- **Total Killed:** 825 ($MS_{all} = 31.58\%$)
- **Total Survived:** 1,787 ($68.42\%$ survival rate)
- **Generic Mutants:** 2,182 valid, 683 killed, 1,499 survived ($MS_{gen} = 31.30\%$, survival rate $68.70\%$)
- **Biological Mutants:** 430 valid, 142 killed, 288 survived ($MS_{bio} = 33.02\%$, survival rate $66.98\%$)
- **Score Divergence:** $\Delta(MS_{bio} - MS_{gen}) = +1.72\%$

### Statistical Tests of Significance
- **Pearson's $\chi^2$ Test:** $\chi^2 = 0.4928$ ($df = 1, p = 0.4827$).
- **Yates' Continuity Corrected $\chi^2$:** $\chi^2 = 0.4163$ ($p = 0.5188$).
- **Odds Ratio ($OR$):** $1.0821$ ($95\%$ Confidence Interval: $[0.868, 1.349]$).
- **Relative Sensitivity ($RS$):** $1.0550$.
- **Inference:** The aggregate metrics confirm statistical parity and domain resilience ($p = 0.4827$) across diverse computational architectures. Standard test suites do not exhibit heightened sensitivity to biological faults; biological corruption evades detection at rates indistinguishable from generic syntactic errors.

---

## 3. Granular Systems Profiles

### 3.1. Salmon (Rust Transcript Quantification)
- **Candidate Mutants:** $N=290$ (82 biological, 208 generic).
- **Compilation Filtering:** 48 rejected via Rust compile-time constraints; 242 valid.
- **Generic Performance:** 19 killed / 208 valid ($MS_{gen} = 9.13\%$, survival rate $90.87\%$).
  - AOR: 2 killed / 13 valid ($15.38\%$)
  - LCR: 16 killed / 158 valid ($10.13\%$)
  - LOG: 1 killed / 32 valid ($3.12\%$)
  - BIT: 0 killed / 5 valid ($0.00\%$)
- **Biological Performance:** 3 killed / 34 valid ($MS_{bio} = 8.82\%$, survival rate $91.18\%$).
- **Statistical Tests:** $\chi^2 = 0.0034$ ($p = 0.9534$), Odds Ratio = $0.9626$ ($95\%$ CI: $[0.269, 3.447]$).
- **Module Highlights:**
  - `online.rs` & `daarem.rs`: 0 / 16 valid killed ($0.0\%$). EM optimizer absorbs parameter perturbations.
  - `seqbias.rs` & `gcbias.rs`: 0 / 67 valid killed ($0.0\%$). Complete verification blindspot in auxiliary bias correction.
  - `fld.rs`: 7 / 25 valid killed ($28.0\%$, $MS_{bio} = 66.7\%$). Fragment length bounds corrupt alignment likelihoods.
  - `libtype.rs`: 5 / 21 valid killed ($23.8\%$). Strandedness and orientation errors drop mapped fragment counts.

### 3.2. Foldseek (3Di Structural Alignment)
- **Candidate Mutants:** $N=274$ (77 biological, 197 generic; 8 TCE equivalents removed).
- **Compilation Filtering:** 50 biological mutants rejected by structural template typing; 210 valid.
- **Generic Performance:** 11 killed / 183 valid ($MS_{gen} = 6.01\%$, survival rate $93.99\%$).
- **Biological Performance:** 10 killed / 27 valid ($MS_{bio} = 37.04\%$, survival rate $62.96\%$).
- **Statistical Tests:** $\chi^2 = 25.1656$ ($p < 0.001$), Yates $\chi^2 = 21.8363$ ($p < 0.001$), Odds Ratio = $9.1979$.
- **Module Highlights:**
  - `StructureSmithWaterman.cpp`: 10 / 40 valid killed ($MS_{all} = 25.0\%$, $MS_{bio} = 50.0\%$). Swapping 3Di matrices corrupts score accumulation.
  - `LDDT.cpp`: 4 / 16 valid killed ($MS_{bio} = 44.4\%$). Swapping coordinate arrays destroys distance difference metrics.
  - `TMaligner.cpp`: 0 / 13 valid killed ($0.0\%$). Distance scaling perturbations absorbed by downstream filters.

### 3.3. Jellyfish (Lock-Free Concurrent K-mer Hashing)
- **Candidate Mutants:** $N=330$ (86 biological, 244 generic).
- **Generic Performance:** 112 killed / 230 valid ($MS_{gen} = 48.70\%$, survival rate $51.30\%$).
- **Biological Performance:** 8 killed / 18 valid ($MS_{bio} = 44.44\%$, survival rate $55.56\%$).
- **Statistical Tests:** $\chi^2 = 0.1208$ ($p = 0.7282$), Odds Ratio = $0.8429$.
- **Module Highlights:**
  - `rectangular_binary_matrix.cc`: 20 / 20 valid killed ($100.0\%$). Hash matrix corruption causes key collisions and memory faults.
  - `count_main.cc`: 0 / 8 valid killed ($0.0\%$). Quality filters and threading flags unexercised on synthetic uniform inputs.

### 3.4. Kallisto (RNA-seq Pseudoalignment)
- **Candidate Mutants:** $N=217$ (22 biological, 195 generic).
- **Generic Performance:** 11 killed / 185 valid ($MS_{gen} = 5.95\%$, survival rate $94.05\%$).
- **Biological Performance:** 1 killed / 17 valid ($MS_{bio} = 5.88\%$, survival rate $94.12\%$).
- **Statistical Tests:** $\chi^2 = 0.0001$ ($p = 0.9915$). Exact operational parity; highest overall survival rate ($94.06\%$).

### 3.5. Kraken2 (Taxonomic Sequence Classification)
- **Candidate Mutants:** $N=192$ (73 biological, 119 generic).
- **Generic Performance:** 12 killed / 117 valid ($MS_{gen} = 10.26\%$, survival rate $89.74\%$).
- **Biological Performance:** 17 killed / 62 valid ($MS_{bio} = 27.42\%$, survival rate $72.58\%$).
- **Statistical Tests:** $\chi^2 = 8.7928$ ($p = 0.0030$), Odds Ratio = $3.31$ ($95\%$ CI: $[1.47, 7.43]$).
- **Module Highlights:**
  - `mmscanner.cc`: 17 / 46 valid killed ($MS_{bio} = 44.4\%$). Minimizer toggle mask corruption causes read classification dropouts.

---

## 4. Execution Timing & Performance Profiling

| System | Incremental Compile Time (s) | Oracle Run Time (s) | Evaluation Mode |
| :--- | :---: | :---: | :--- |
| **SAMtools** | ~0.15s | ~0.45s | Static Library Object Injection (`ar csru`) |
| **GROMACS** | ~0.25s | ~1.20s | Modular Object Relink |
| **IQ-TREE 3** | ~0.35s | ~2.10s | Static Model Archive Injection |
| **BWA** | ~0.18s | ~0.55s | Static Archive Update (`libbwa.a`) |
| **RAxML-NG** | ~0.40s | ~1.85s | Linker Command Script Relink |
| **Kraken2** | ~0.20s | ~0.60s | Standalone Object Link |
| **Kallisto** | ~0.25s | ~0.80s | Build Object Relink |
| **Jellyfish** | ~0.22s | ~0.50s | Libtool Static Link |
| **Foldseek** | ~0.25s | ~0.75s | Static Framework Update (`libfoldseek-framework.a`) |
| **Salmon** | ~0.44s–5.5s | ~0.55s | Cargo Incremental Debug Build with Symlink Target Cache |
