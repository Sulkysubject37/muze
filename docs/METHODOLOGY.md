# Research Methodology & Theoretical Framework

## 1. Central Research Question & Hypotheses

Bioinformatics algorithms routinely process massive, noisy genomic and structural datasets using heuristic alignments, probabilistic graphs, and continuous numerical optimization. These functional properties establish a pervasive **oracle problem**, wherein expected output states cannot be derived via manual inspection.

This research investigates whether standard developer-written test suites detect domain-specific biological logic corruption, or whether they primarily verify program execution completion and syntactic scaffolding.

### Formal Hypotheses
- **Null Hypothesis ($H_0$):** Domain-specific biological mutation scores equal generic mutation scores ($MS_{bio} = MS_{gen}$).
- **Alternative Hypothesis ($H_1$):** Domain-specific biological mutation scores are less than or equal to generic mutation scores ($MS_{bio} \le MS_{gen}$). Biological faults evade developer assertions at equal or higher rates than generic software faults due to algorithmic resilience and fault-masking.

---

## 2. The Dual-Oracle Experimental Design

To decouple fault detectability from test suite coverage deficiencies, the methodology formulates a **Dual-Oracle Framework**:

```
                       [ Compiled Mutant ]
                                │
                 ┌──────────────┴──────────────┐
                 ▼                             ▼
       [ Oracle A: Differential ]    [ Oracle B: Test Suite ]
       (Direct Output Bit-Check)     (Developer Assertions)
                 │                             │
                 ▼                             ▼
             Verdict d                     Verdict t
                 └──────────────┬──────────────┘
                                ▼
                   [ Categorical Classification ]
```

### The $2 \times 2$ Evaluation Matrix

| Category | Boolean Condition | Epistemological Meaning |
| :--- | :---: | :--- |
| **Strong Kill** | $d \land t$ | Fault alters mathematical output and triggers developer assertions. |
| **Silent to Tests** | $d \land \neg t$ | Fault corrupts output state but completely bypasses developer assertions. |
| **Assertion Only** | $\neg d \land t$ | Test fails (e.g., timing/memory/unexercised path) without output change. |
| **Full Escape** | $\neg d \land \neg t$ | Fault evades both oracles (semantic equivalent or deep coverage hole). |

---

## 3. The Differential Oracle Gap ($\Delta$ P1 + P2)

In early controlled experiments (Phase 1 and Phase 2), an isolated sandbox comprising 60 algorithms reimplemented in both C and memory-safe Zig was evaluated:

1. **Phase 1 Baseline:** Pure differential output comparison against reference C binaries yielded $MS_{diff} = 86.15\%$ (56 / 65 killed).
2. **Phase 2 Naive Exact-Value Suite:** Artificially constructing exact-value assertions at algorithmic boundaries inflated detection to $MS_{test} = 99.31\%$ (143 / 144 killed), an artifact of artificial suite contamination.
3. **Empirical Calibration:** An empirical survey of upstream bioinformatics repositories (including BWA, Kallisto, and GROMACS) revealed that 3 of 10 tools possessed zero automated verification for core algorithmic modules. Across repositories with test suites, assertions were distributed as:
   - **60% Exact-Value Assertions** (natural, non-boundary inputs).
   - **37% Weak Sanity Assertions** (e.g., `result > 0`, `result != NULL`).
   - **3% Boundary-Sensitive Checks**.
4. **Empirical Results ($\Delta$ P1 + P2):** Re-evaluating the 60 algorithms under the empirical distribution exposed a massive **26.57% test evasion gap** ($N=38$ mutants classified as `SILENT_TO_TESTS`), proving that biological algorithms silently produce corrupted results while fully satisfying CI test pipelines.

---

## 4. Phase 4 Native Production Evaluation Protocol

To validate findings beyond sandboxed environments, Phase 4 deployed the Modular Orchestrator across ten production repositories spanning C, C++, and Rust.

### Experimental Calibration & Quotas
To prevent generic operator inflation from skewing comparative metrics, operator allocations were strictly bounded:
- **Biological Operator Quota:** $70 < N_{bio} < 90$ candidates.
- **Generic Operator Quota:** $N_{gen} \ge 130$ candidates (AOR, LCR, LOG, BIT).

### Trivial Compiler Equivalence (TCE) Filtering
Before test execution, every mutant is compiled to native object code and cryptographically hashed (SHA-256). Mutants yielding object hashes identical to the unmutated baseline are discarded as compiler equivalents, ensuring that only semantically distinct logic mutations are tested.

---

## 5. Statistical Testing Procedures

For each tool and across the aggregate multi-discipline pool, contingency tables ($2 \times 2$) of valid mutant evaluations are analyzed:

$$\begin{pmatrix} K_{bio} & S_{bio} \\ K_{gen} & S_{gen} \end{pmatrix}$$

Where:
- $K$ = Number of mutants killed by the test oracle.
- $S$ = Number of mutants surviving test execution.

### Metrics Computed:
1. **Mutation Score ($MS$):**
   $$MS = \frac{K}{K + S} \times 100\%$$
2. **Pearson's Chi-Squared Test ($\chi^2$):**
   $$\chi^2 = \sum \frac{(O - E)^2}{E}, \quad df = 1$$
3. **Yates' Continuity Corrected $\chi^2$:**
   $$\chi^2_{\text{Yates}} = \frac{N (|K_{bio} S_{gen} - S_{bio} K_{gen}| - N/2)^2}{(K_{bio} + S_{bio})(K_{gen} + S_{gen})(K_{bio} + K_{gen})(S_{bio} + S_{gen})}$$
4. **Odds Ratio ($OR$):**
   $$OR = \frac{K_{bio} \cdot S_{gen}}{S_{bio} \cdot K_{gen}}, \quad 95\% \text{ CI} = \exp\left(\ln OR \pm 1.96 \sqrt{\frac{1}{K_{bio}} + \frac{1}{S_{bio}} + \frac{1}{K_{gen}} + \frac{1}{S_{gen}}}\right)$$
5. **Relative Sensitivity ($RS$):**
   $$RS = \frac{MS_{bio}}{MS_{gen}}$$
