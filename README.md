# MUZE: Mutator Utility for Zero-memory-fault Evaluations

**MUZE** is an academic Mutation Testing Framework designed specifically to validate the core thesis: *Memory safety does not equate to biological semantic safety.*

Built natively in Zig (0.16.x) with C-interoperability, MUZE evaluates how structural syntactic mutations (`<` to `<=`, `+` to `-`) bypass standard test suites and gracefully corrupt biological algorithms without triggering memory faults or crashes.

## The Dual-Sandbox Architecture
Contains algorithmically simplified reimplementations of core routines from [tools], written to isolate the semantic properties of interest without carrying the full complexity of production codebases.

A line-by-line translation of those simplified C routines into memory-safe Zig. Same algorithms, same control flow — the only variable is language-level memory safety.

By running mutations on *both*, MUZE proves that biological semantics fail silently regardless of the underlying language's memory guarantees.

## Pipeline Features
* **Native AST Parsing:** Uses Zig's `std.zig.Ast` to surgically slice and manipulate syntax trees without external dependencies.
* **Trivial Compiler Equivalence (TCE):** Hashes compiled LLVM IR (`.ll`) to automatically detect and discard equivalent "ghost" mutants optimized away by the compiler.
* **Watchdog Execution:** Spawns strictly timed sub-processes to catch catastrophic biological infinite loops (e.g., corrupted phylogenetic Lowest Common Ancestor traversals).

## Project Structure
- `src/mutator.zig`: The core orchestration engine and AST parser.
- `src/sandbox_native.c`: The native C snippets (FM-Index bounds, 2-bit DNA encoding, etc.).
- `src/sandbox_safe.zig`: The memory-safe Zig ports of the biological logic.
- `build.zig`: The Zig 0.16 build system managing compilation, TCE hashing, and test execution.
- `build.zig.zon`: The Zig requirement for interop and other operations. 
