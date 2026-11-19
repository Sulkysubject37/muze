# Taxonomy and Directory of Mutation Operators

## 1. Overview and Design Principles

MUZE establishes a structured taxonomy partitioned into **Generic Software Operators** and **Domain-Specific Biological Operators**. This dual taxonomy investigates whether conventional software engineering test suites are sensitive to biological domain corruption, or whether they primarily detect generic syntax errors and process aborts.

---

## 2. Generic Mutation Operators

Generic operators represent standard syntax modifications widely utilized in mutation testing literature. These operators target universal programming constructs across C, C++, and Rust:

| Class | Operator Name | Source Target | Replacement | Description |
| :--- | :--- | :---: | :---: | :--- |
| **AOR** | Arithmetic Operator Replacement | `!=` | `==` | Inverts equality/inequality conditions in arithmetic or loop guards. |
| **LCR** | Logical Constant / Sign Replacement | `+` | `-` | Inverts arithmetic addition to subtraction. |
| **LCR** | Logical Constant / Sign Replacement | `-` | `+` | Inverts arithmetic subtraction to addition. |
| **LOG** | Boolean Logic Replacement | `&&` | `\|\|` | Replaces logical conjunction with disjunction. |
| **LOG** | Boolean Logic Replacement | `\|\|` | `&&` | Replaces logical disjunction with conjunction. |
| **BIT** | Bitwise Operator Replacement | `&` | `\|` | Replaces bitwise AND with bitwise OR. |
| **BIT** | Bitwise Operator Replacement | `\|` | `&` | Replaces bitwise OR with bitwise AND. |

---

## 3. Domain-Specific Biological Operators

Biological operators directly mutate scientific algorithms, domain invariants, and mathematical modeling parameters. These operators are calibrated for each specific computational paradigm:

### 3.1. SAMtools (Genomic Sequence & Alignment Processing)
- **Flag Inversion (`BAM_FPAIRED` $\leftrightarrow$ `BAM_FREVERSE`):** Inverts primary paired-end read designation to reverse-strand alignment flag.
- **Proper Pair Flag Alteration (`BAM_FPAIRED` $\leftrightarrow$ `BAM_FPROPER_PAIR`):** Alters pair configuration flags, disrupting insert-size validation.
- **Secondary Alignment Perturbation (`BAM_FSECONDARY` $\leftrightarrow$ `BAM_FQCFAIL`):** Replaces multi-mapping secondary read flags with vendor quality failure flags.
- **Duplicate Marking Inversion (`BAM_FDUP` $\leftrightarrow$ `BAM_FPAIRED`):** Corrupts PCR duplicate tracking in BAM alignments.
- **CIGAR Alignment Operator Swapping (`BAM_CMATCH` $\leftrightarrow$ `BAM_CINS`, `BAM_CDEL` $\leftrightarrow$ `BAM_CREF_SKIP`):** Swaps alignment match/insertion operations and deletion/intron-skip operations, corrupting genomic coordinate translation.

### 3.2. GROMACS (Molecular Dynamics & Biophysical Simulation)
- **Integration Timestep Perturbation (`dt` $\leftrightarrow$ `dt * 2.0`, `dt * 0.5`):** Distorts leap-frog integrator step sizes, altering energy conservation.
- **Thermostat Coupling Relaxation (`tau_t` $\leftrightarrow$ `tau_t * 0.1`):** Accelerates or dampens velocity rescaling, disrupting thermal equilibrium.
- **Barostat Pressure Coupling Alteration (`tau_p` $\leftrightarrow$ `tau_p * 10.0`):** Mutates pressure relaxation times, inducing density oscillations.
- **Virial Tensor Inversion (`vir[XX][XX]` $\leftrightarrow$ `-vir[XX][XX]`):** Inverts diagonal pressure tensor components.
- **Periodic Boundary Conditions (PBC) Shifting (`box[XX][XX]` $\leftrightarrow$ `box[YY][YY]`):** Perturbs box coordinate matrices, breaking minimum image conventions.

### 3.3. IQ-TREE 3 & RAxML-NG (Phylogenetic Likelihood & Tree Search)
- **Markov Transition Rate Matrix Mutation:** Swaps substitution rate parameters ($Q_{ij} \leftrightarrow Q_{ji}$) in continuous Markov models.
- **Gamma Shape Parameter Inversion ($\alpha \leftrightarrow 1.0 / \alpha$):** Inverts discrete Gamma rate heterogeneity distribution curvature.
- **Transition/Transversion Ratio Mutation ($\kappa \leftrightarrow 1.0 / \kappa$):** Disrupts purine-pyrimidine substitution dynamics.
- **Branch Length Bounds Inversion (`min_brlen` $\leftrightarrow$ `max_brlen`):** Forces branch length optimization against extreme evolutionary boundaries.
- **SPR Search Radius Step Alteration:** Perturbs Subtree Pruning and Regrafting topological search steps, distorting heuristic tree exploration.
- **Likelihood Scaling Epsilon Clamp:** Alters underflow protection thresholds and likelihood convergence tolerances.

### 3.4. BWA (Burrows-Wheeler Short-Read Sequence Alignment)
- **FM-Index Interval Bounds Inversion ($k = L2[c] + \text{ok} + 1 \leftrightarrow -$):** Disrupts backward search interval accumulation in suffix arrays.
- **2Occ Rank Interval Offset Perturbation:** Inverts rank offset indexing, corrupting occurrence lookups.
- **Nucleotide Complement Mapping ($3 - q[i] \leftrightarrow +$):** Inverts 2-bit DNA reverse complement calculations.
- **MEM Seed Chaining Band Width Constraints:** Inverts distance thresholds during maximal exact match seed chaining.
- **Affine Gap Penalty Inversion ($o\_del \leftrightarrow +$, $e\_ins \leftrightarrow +$):** Swaps affine gap open and extension costs, altering alignment traceback geometry.

### 3.5. Kraken2 (Metagenomic Exact-Match Taxonomic Classification)
- **Minimizer Toggle Mask Inversion:** Corrupts the XOR toggle mask utilized to break low-complexity homopolymer minimizer ties.
- **Minimizer Length Clamping:** Truncates minimizer $M$-mer window lengths, forcing aberrant index querying.
- **Canonical DNA Orientation Toggle:** Disables canonical strand conversion, producing unindexed reverse complement lookups.
- **Lowest Common Ancestor (LCA) Tree Climber Perturbation:** Clamps ancestor tree traversal steps, forcing classification to aberrant taxonomic ranks.

### 3.6. Kallisto (RNA-seq Pseudoalignment & EM Quantification)
- **de Bruijn Graph Index Unitig Bounds:** Perturbs $k$-mer index lookups and equivalence class mapping arrays.
- **Dirichlet Prior Mass Reset:** Clears prior abundance smoothing, disrupting Bayesian regularization on low-expression transcripts.
- **Online EM Forgetting Factor Inversion ($\alpha \leftrightarrow 1.0 - \alpha$):** Inverts historical read weighting in the streaming expectation-maximization solver.
- **Effective Transcript Length Guard Mutation:** Inverts fragment length corrections against transcript lengths.

### 3.7. Jellyfish (Lock-Free Concurrent $K$-mer Counting & Hashing)
- **Rectangular Binary Matrix Inversion:** Disrupts pseudo-random linear bit-vector transformations, destroying hash distribution uniformity.
- **Phred Quality Score Filter Clamping:** Clamps minimum Phred quality filters, causing ambiguous or low-quality bases to be counted as high-confidence $k$-mers.
- **Concurrent Hash Counter Step Inversion:** Mutates lock-free atomic CAS counter increments, corrupting distinct cardinality estimations.

### 3.8. Foldseek (Macromolecular 3Di Structural Alignment)
- **3Di Structural Alphabet Matrix Swap (`subMat3Di` $\leftrightarrow$ `subMatAA`):** Swaps 3Di structural alphabet substitution matrices with standard amino acid matrices.
- **Affine Gap Penalty Swapping (`gap_open` $\leftrightarrow$ `gap_extend`):** Swaps gap opening and gap extension costs during structural dynamic programming.
- **Compositional Bias Table Swapping:** Inverts background structural sequence frequency adjustments.
- **$C_\alpha$ Coordinate Pointer Swapping (`query_coordinates` $\leftrightarrow$ `target_coordinates`):** Induces coordinate asymmetry in TM-score superpositions.
- **TM-Score Distance Scaling Alteration (`d0`, `rmsd0`):** Distorts length-normalized structural similarity metrics.

### 3.9. Salmon (Expectation-Maximization Transcript Quantification in Rust)
- **Prior Dirichlet Mass Reset (`prior_mass` $\rightarrow$ `0.0`):** Disables abundance priors across transcript isoforms.
- **Online EM Forgetting Factor Inversion ($\alpha \leftrightarrow 1.0 - \alpha$):** Causes the online optimizer to amplify stale batches while decaying current observations.
- **Burn-in Fragment Clamping (`burnin` $\rightarrow$ `0`):** Eliminates model calibration warm-up fragments prior to offline EM updates.
- **Fragment Length Distribution Bounds Inversion:** Clamps FLD empirical kernel densities, corrupting read alignment probabilities.
- **Sequencing Library Compatibility Inversion (`libtype`):** Inverts strandedness and mate orientation flags, rejecting valid paired-end alignments.
- **Log-Sum-Exp Normalization Inversion:** Mutates probability normalization primitives in log-space arithmetic.
