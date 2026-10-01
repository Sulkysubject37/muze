const std = @import("std");

/// MUZE: Mutator Utility for Zero-memory-fault Evaluations
/// Phase 1 & 2: Ingests the Sandbox and Parses the AST for targets.
pub fn main(init: std.process.Init) !void {
    var arena = std.heap.ArenaAllocator.init(init.gpa);
    defer arena.deinit();
    const allocator = arena.allocator();

    std.debug.print("Initializing MUZE AST Parser...\n", .{});
    _ = system("rm -rf tmp && mkdir -p tmp");

    // Phase 1: Ingest sandbox_safe.zig (Compile-Time Embedding for absolute robustness)
    const source = @embedFile("sandbox_safe.zig");
    
    // Phase 2: Parse AST natively (std.zig.Ast) & Extract Targets
    var ast = try std.zig.Ast.parse(allocator, source, .zig);
    defer ast.deinit(allocator);

    const TokenRange = struct { start: u32, end: u32 };
    var test_ranges = std.ArrayList(TokenRange).empty;
    defer test_ranges.deinit(allocator);

    for (ast.rootDecls()) |decl| {
        const decl_idx = @intFromEnum(decl);
        const tag = ast.nodes.items(.tag)[decl_idx];
        if (tag == .test_decl) {
            try test_ranges.append(allocator, .{
                .start = ast.firstToken(decl),
                .end   = ast.lastToken(decl),
            });
        }
    }

    const in_test_block = struct {
        fn check(ranges: []const TokenRange, tok: u32) bool {
            for (ranges) |r| {
                if (tok >= r.start and tok <= r.end) return true;
            }
            return false;
        }
    }.check;

    std.debug.print("[AST] {d} test block(s) excluded from mutation\n", .{test_ranges.items.len});

    std.debug.print("Successfully parsed embedded sandbox_safe.zig. Total tokens: {d}\n", .{ast.tokens.len});

    // Biological Mutator Patch Included via ed/sed logic
    const BioMutator = struct {
        name: []const u8,
        target_sequence: []const []const u8,
        mutate_idx: usize,
        replacement: []const u8,
    };
    const bio_mutators = [_]BioMutator{
        .{ .name = "Canonical Strand Bias Injection", .target_sequence = &[_][]const u8{"kmer", "<", "rc"}, .mutate_idx = 1, .replacement = ">" },
        .{ .name = "Sliding Window Truncation", .target_sequence = &[_][]const u8{"j", "<=", "w", "-", "k"}, .mutate_idx = 1, .replacement = "<" },
        .{ .name = "Minimizer Hash Avalanche Corruption", .target_sequence = &[_][]const u8{"hash", ">>", "15"}, .mutate_idx = 1, .replacement = "<<" },
        .{ .name = "BWT 0-to-1 Index Fault", .target_sequence = &[_][]const u8{"(", "sp", "-", "1", ")"}, .mutate_idx = 2, .replacement = "+" },
        .{ .name = "BWT Exclusive Bounds", .target_sequence = &[_][]const u8{"]", "-", "1"}, .mutate_idx = 1, .replacement = "+" },
        .{ .name = "Phylogenetic Depth Truncation 1", .target_sequence = &[_][]const u8{"tree", "[", "u", "]", ".", "depth", ">", "tree", "[", "v", "]", ".", "depth"}, .mutate_idx = 6, .replacement = ">=" },
        .{ .name = "Phylogenetic Depth Truncation 2", .target_sequence = &[_][]const u8{"tree", "[", "v", "]", ".", "depth", ">", "tree", "[", "u", "]", ".", "depth"}, .mutate_idx = 6, .replacement = ">=" },
        .{ .name = "LCA Early Termination", .target_sequence = &[_][]const u8{"u", "!=", "v"}, .mutate_idx = 1, .replacement = "==" },
        .{ .name = "Steric Collapse", .target_sequence = &[_][]const u8{"total_energy", "+="}, .mutate_idx = 1, .replacement = "-=" },
        .{ .name = "Periodic Boundary Violation", .target_sequence = &[_][]const u8{"dx", "-="}, .mutate_idx = 1, .replacement = "+=" },
        .{ .name = "Minimizer Initialization Fault", .target_sequence = &[_][]const u8{"std", ".", "math", ".", "maxInt"}, .mutate_idx = 4, .replacement = "minInt" },
        .{ .name = "Kraken2 LCA Monotonicity Fault", .target_sequence = &[_][]const u8{"a", ">", "b"}, .mutate_idx = 1, .replacement = "<" },
        .{ .name = "Kraken2 Reading Frame Shift", .target_sequence = &[_][]const u8{"i", "%", "3"}, .mutate_idx = 2, .replacement = "2" },
        .{ .name = "Kraken2 Junk DNA Masking Threshold Fault", .target_sequence = &[_][]const u8{"*", "10", ">", "threshold"}, .mutate_idx = 2, .replacement = ">=" },
        .{ .name = "Jellyfish Bloom Filter Saturation", .target_sequence = &[_][]const u8{"k_hashes", "=", "3"}, .mutate_idx = 2, .replacement = "1" },
        .{ .name = "Jellyfish CAS Counter Overflow", .target_sequence = &[_][]const u8{"count", "<", "max_count"}, .mutate_idx = 1, .replacement = "<=" },
        // --- Kallisto ---
        .{ .name = "Kallisto EC Logical Union Fault",
           .target_sequence = &[_][]const u8{"0", "and", "(", "ec_set"},
           .mutate_idx = 1, .replacement = "or" },
        .{ .name = "Kallisto EC Bitwise Mask Fault",
           .target_sequence = &[_][]const u8{"read_set", "&", "mask"},
           .mutate_idx = 1, .replacement = "|" },
        .{ .name = "Kallisto EC Accumulator Fault",
           .target_sequence = &[_][]const u8{"result", "|=", "mask"},
           .mutate_idx = 1, .replacement = "&=" },
        .{ .name = "Kallisto EM Noise Truncation Boundary Fault",
           .target_sequence = &[_][]const u8{"prob", "<", "noise_limit"},
           .mutate_idx = 1, .replacement = "<=" },
        .{ .name = "Kallisto Effective Length Guard Fault",
           .target_sequence = &[_][]const u8{"eff_len", "<", "1.0"},
           .mutate_idx = 1, .replacement = "<=" },
        .{ .name = "Kallisto Palindromic K-mer Constraint Fault",
           .target_sequence = &[_][]const u8{"2", "!=", "0", "and"},
           .mutate_idx = 1, .replacement = "==" },
        .{ .name = "Kallisto Strand Flip Inversion Fault",
           .target_sequence = &[_][]const u8{"packed_pos", "|=", "0x80000000"},
           .mutate_idx = 1, .replacement = "&=" },
        .{ .name = "Kallisto UMI Threshold Tightening Fault",
           .target_sequence = &[_][]const u8{"dist", "<=", "threshold"},
           .mutate_idx = 1, .replacement = "<" },
        // --- SAMtools ---
        .{ .name = "SAMtools BED Half-Open Interval Fault",
           .target_sequence = &[_][]const u8{"pos", "<", "end"},
           .mutate_idx = 1, .replacement = "<=" },
        .{ .name = "SAMtools VCF Coordinate Shift Fault",
           .target_sequence = &[_][]const u8{"pos", "+", "1"},
           .mutate_idx = 1, .replacement = "-" },
        .{ .name = "SAMtools BAM Strand Bitwise Fault",
           .target_sequence = &[_][]const u8{"flag", "&", "0x10"},
           .mutate_idx = 1, .replacement = "|" },
        .{ .name = "SAMtools IUPAC N-Match Fault",
           .target_sequence = &[_][]const u8{"c2", "and", "c2"},
           .mutate_idx = 1, .replacement = "or" },
        .{ .name = "SAMtools Unclipped Start Fault",
           .target_sequence = &[_][]const u8{"pos", "-", "clip_len"},
           .mutate_idx = 1, .replacement = "+" },
        .{ .name = "SAMtools Proper Pair Logical Fault",
           .target_sequence = &[_][]const u8{"0", "and", "("},
           .mutate_idx = 1, .replacement = "or" },
        // --- BWA ---
        .{ .name = "BWA Sentinel Shift Boundary Fault",
           .target_sequence = &[_][]const u8{"k", ">=", "primary"},
           .mutate_idx = 1, .replacement = ">" },
        .{ .name = "BWA Ambiguous Base Filter Fault",
           .target_sequence = &[_][]const u8{"base_code", "<", "4"},
           .mutate_idx = 1, .replacement = "<=" },
        .{ .name = "BWA Affine Gap Penalty Operator Fault",
           .target_sequence = &[_][]const u8{"q", "+", "r"},
           .mutate_idx = 1, .replacement = "-" },
        .{ .name = "BWA SIMD Saturation Logical Fault",
           .target_sequence = &[_][]const u8{"255", "or", "gmax"},
           .mutate_idx = 1, .replacement = "and" },
        .{ .name = "BWA Chain Collinearity Boundary Fault",
           .target_sequence = &[_][]const u8{"x", "<=", "bw"},
           .mutate_idx = 1, .replacement = "<" },
        .{ .name = "BWA Pair Strand XOR Fault",
           .target_sequence = &[_][]const u8{"r1", "^", "r2"},
           .mutate_idx = 1, .replacement = "|" },
        .{ .name = "BWA Insert Size Arithmetic Fault",
           .target_sequence = &[_][]const u8{"p25", "-", "bound"},
           .mutate_idx = 1, .replacement = "+" },
        // --- Salmon ---
        .{ .name = "Salmon Reverse Complement Index Fault",
           .target_sequence = &[_][]const u8{"seq_len", "-", "1"},
           .mutate_idx = 1, .replacement = "+" },
        .{ .name = "Salmon EC Filter Equality Fault",
           .target_sequence = &[_][]const u8{"is_compat", "==", "1"},
           .mutate_idx = 1, .replacement = "!=" },
        .{ .name = "Salmon EM Convergence Boundary Fault",
           .target_sequence = &[_][]const u8{"alpha", ">", "cutoff"},
           .mutate_idx = 1, .replacement = ">=" },
        .{ .name = "Salmon RAD Packing Bitwise Fault",
           .target_sequence = &[_][]const u8{"tid", "|", "("},
           .mutate_idx = 1, .replacement = "^" },
        .{ .name = "Salmon Ambiguous Base Fallback Fault",
           .target_sequence = &[_][]const u8{"return", "78", ";"},
           .mutate_idx = 1, .replacement = "65" },
        .{ .name = "Salmon CIGAR State Mapping Fault",
           .target_sequence = &[_][]const u8{"op", "==", "1"},
           .mutate_idx = 1, .replacement = "!=" },
        // --- GROMACS ---
        .{ .name = "GROMACS Leapfrog Integrator Sign Fault",
           .target_sequence = &[_][]const u8{"x", "+", "v"},
           .mutate_idx = 1, .replacement = "-" },
        .{ .name = "GROMACS V-rescale Ratio Fault",
           .target_sequence = &[_][]const u8{"ek_new", "/", "ek"},
           .mutate_idx = 1, .replacement = "*" },
        .{ .name = "GROMACS Periodic Wrap Floor Fault",
           .target_sequence = &[_][]const u8{"@floor"},
           .mutate_idx = 0, .replacement = "@ceil" },
        .{ .name = "GROMACS Halo Buffer Size Fault",
           .target_sequence = &[_][]const u8{"num", "+", "1"},
           .mutate_idx = 1, .replacement = "-" },
        .{ .name = "GROMACS 1-4 Fudge Scaling Fault",
           .target_sequence = &[_][]const u8{"raw_qq", "*", "fudge"},
           .mutate_idx = 1, .replacement = "+" },
        .{ .name = "GROMACS Umbrella Spring Sign Fault",
           .target_sequence = &[_][]const u8{"return", "-", "k"},
           .mutate_idx = 1, .replacement = " " },
        // --- Foldseek ---
        .{ .name = "Foldseek C-Beta Geometry Coefficient Fault",
           .target_sequence = &[_][]const u8{"0.333333", "*", "u_1"},
           .mutate_idx = 0, .replacement = "0.5" },
        .{ .name = "Foldseek lDDT Self-Inclusion Fault",
           .target_sequence = &[_][]const u8{"col", "!=", "row"},
           .mutate_idx = 1, .replacement = "==" },
        .{ .name = "Foldseek TM-Score Short-Circuit Fault",
           .target_sequence = &[_][]const u8{"0", "or", "d"},
           .mutate_idx = 1, .replacement = "and" },
        .{ .name = "Foldseek Saturating Gap Penalty Fault",
           .target_sequence = &[_][]const u8{"vH", "<", "vGapO"},
           .mutate_idx = 1, .replacement = ">" },
        .{ .name = "Foldseek pLDDT Mask Inversion Fault",
           .target_sequence = &[_][]const u8{"bfactor", "<", "threshold"},
           .mutate_idx = 1, .replacement = ">=" },
        .{ .name = "Foldseek E-value Scaling Constant Fault",
           .target_sequence = &[_][]const u8{"*", "0.175"},
           .mutate_idx = 1, .replacement = "0.5" },
        // --- RAxML ---
        .{ .name = "RAxML Base Frequency Bound Fault",
           .target_sequence = &[_][]const u8{"base_freq", ">=", "1.0"},
           .mutate_idx = 1, .replacement = ">" },
        .{ .name = "RAxML Substitution Rate Normalization Fault",
           .target_sequence = &[_][]const u8{"rate", "/", "ref_rate"},
           .mutate_idx = 1, .replacement = "*" },
        .{ .name = "RAxML Branch Length Clamp Inversion Fault",
           .target_sequence = &[_][]const u8{"length", "<", "min_len"},
           .mutate_idx = 1, .replacement = ">" },
        .{ .name = "RAxML Likelihood Improvement Boundary Fault",
           .target_sequence = &[_][]const u8{"old_score", ">", "epsilon"},
           .mutate_idx = 1, .replacement = ">=" },
        .{ .name = "RAxML Ancestral Tie-Break Boundary Fault",
           .target_sequence = &[_][]const u8{"p1", ">", "p2"},
           .mutate_idx = 1, .replacement = ">=" },
        .{ .name = "RAxML Bipartition Conflict Inversion Fault",
           .target_sequence = &[_][]const u8{"is_compatible", "==", "0"},
           .mutate_idx = 1, .replacement = "!=" },
        // --- IQ-TREE ---
        .{ .name = "IQ-TREE Bootstrap Replacement Mode Fault",
           .target_sequence = &[_][]const u8{"replace_flag", "==", "1"},
           .mutate_idx = 1, .replacement = "!=" },
        .{ .name = "IQ-TREE Underflow Scaler Logical Fault",
           .target_sequence = &[_][]const u8{"likelihood", "<", "threshold"},
           .mutate_idx = 1, .replacement = ">" },
        .{ .name = "IQ-TREE Alignment Mask Bitwise Fault",
           .target_sequence = &[_][]const u8{"addr", "&", "mask"},
           .mutate_idx = 1, .replacement = "|" },
        .{ .name = "IQ-TREE NNI Symmetric Swap Fault",
           .target_sequence = &[_][]const u8{"a", "=", "a", "^", "b"},
           .mutate_idx = 3, .replacement = "&" },
        .{ .name = "IQ-TREE Branch Time Clamp Fault",
           .target_sequence = &[_][]const u8{"length", "<=", "0.0"},
           .mutate_idx = 1, .replacement = "<" },
        .{ .name = "IQ-TREE Mixture Weight Normalization Fault",
           .target_sequence = &[_][]const u8{"weight", "/", "sum"},
           .mutate_idx = 1, .replacement = "*" },
    };

    // Cache token tag and start arrays once — indexed access is what we need.
    const tags   = ast.tokens.items(.tag);
    const starts = ast.tokens.items(.start);

    var target_count: usize = 0;

    // AST Traversal: Hunt for biological structural faults.
    //
    // Invariant: no matched token position may be a comment, doc comment,
    // or any fragment of a string/char literal. This makes the operator
    // table safe against accidental hits inside documentation or data.
    var i: usize = 0;
    outer: while (i < ast.tokens.len) : (i += 1) {
        pattern: for (bio_mutators) |mut| {
            // Bounds: the full pattern must fit within the remaining token stream.
            if (i + mut.target_sequence.len > ast.tokens.len) continue :pattern;

            // Invariant: mutate_idx must address a token inside the pattern.
            std.debug.assert(mut.mutate_idx < mut.target_sequence.len);

            // Pass 1 — reject any position whose tag marks it as
            // comment text or literal payload. Zig's tokenizer emits
            // each of these constructs as a single token, so this
            // eliminates the entire class of shadow matches.
            for (0..mut.target_sequence.len) |j| {
                const tok_idx = @as(u32, @intCast(i + j));
                if (in_test_block(test_ranges.items, tok_idx)) continue :pattern;
                switch (tags[tok_idx]) {
                    .multiline_string_literal_line,
                    .string_literal,
                    .char_literal,
                    => continue :pattern,
                    else => {},
                }
            }

            // Pass 2 — compare the textual slice of every token.
            for (mut.target_sequence, 0..) |expected_tok, j| {
                const tok_idx = i + j;
                if (!std.mem.eql(u8, ast.tokenSlice(@intCast(tok_idx)), expected_tok)) {
                    continue :pattern;
                }
            }

            // Match confirmed — splice the mutated token.
            const mutate_token_idx: usize = i + mut.mutate_idx;
            const start_byte = starts[mutate_token_idx];
            const end_byte   = start_byte + ast.tokenSlice(@intCast(mutate_token_idx)).len;

            std.debug.print("[BIOLOGICAL FAULT INJECTED] {s}\n   -> Pattern: ", .{mut.name});
            for (mut.target_sequence) |t| std.debug.print("{s} ", .{t});
            std.debug.print("\n", .{});

            const prefix = source[0..start_byte];
            const suffix = source[end_byte..source.len];

            var mutant_source = std.ArrayList(u8).empty;
            try mutant_source.appendSlice(allocator, prefix);
            try mutant_source.appendSlice(allocator, mut.replacement);
            try mutant_source.appendSlice(allocator, suffix);

            _ = std.c.mkdir("tmp", 0o755);
            var filename_buf: [64]u8 = undefined;
            const filename = try std.fmt.bufPrintZ(&filename_buf, "tmp/mutant_{d}.zig", .{target_count});

            const fp = std.c.fopen(filename, "w") orelse return error.CreateFileFailed;
            _ = std.c.fwrite(mutant_source.items.ptr, 1, mutant_source.items.len, fp);
            _ = std.c.fclose(fp);
            mutant_source.deinit(allocator);

            target_count += 1;
            i += mut.target_sequence.len; // Skip past this match.
            continue :outer;
        }
    }
    // ---------- Phase 2b: Generic operators, one per function per class ----------

    const GenPattern = struct {
        tokens: []const []const u8,
        replacement: []const u8,
    };

    const gen_aor = [_]GenPattern{
        .{ .tokens = &[_][]const u8{"+"}, .replacement = "-" },
        .{ .tokens = &[_][]const u8{"-"}, .replacement = "+" },
        .{ .tokens = &[_][]const u8{"*"}, .replacement = "/" },
        .{ .tokens = &[_][]const u8{"/"}, .replacement = "*" },
    };
    const gen_ror = [_]GenPattern{
        .{ .tokens = &[_][]const u8{"<"},  .replacement = "<=" },
        .{ .tokens = &[_][]const u8{">"},  .replacement = ">=" },
        .{ .tokens = &[_][]const u8{"<="}, .replacement = "<" },
        .{ .tokens = &[_][]const u8{">="}, .replacement = ">" },
        .{ .tokens = &[_][]const u8{"=="}, .replacement = "!=" },
        .{ .tokens = &[_][]const u8{"!="}, .replacement = "==" },
    };
    const gen_lcr = [_]GenPattern{
        .{ .tokens = &[_][]const u8{"and"}, .replacement = "or" },
        .{ .tokens = &[_][]const u8{"or"},  .replacement = "and" },
    };

    for (ast.rootDecls()) |decl| {
        const decl_idx = @intFromEnum(decl);
        const tag = ast.nodes.items(.tag)[decl_idx];
        if (tag != .fn_decl) continue;

        const fn_first = ast.firstToken(decl);
        const fn_last  = ast.lastToken(decl);

        const classes = [_]struct { name: []const u8, pats: []const GenPattern }{
            .{ .name = "AOR", .pats = &gen_aor },
            .{ .name = "ROR", .pats = &gen_ror },
            .{ .name = "LCR", .pats = &gen_lcr },
        };

        for (classes) |cls| {
            var found = false;
            var t: usize = fn_first;
            while (t + 1 <= fn_last and !found) : (t += 1) {
                for (cls.pats) |p| {
                    if (t + p.tokens.len > fn_last + 1) continue;
                    if (in_test_block(test_ranges.items, @intCast(t))) continue;
                    var m = true;
                    for (p.tokens, 0..) |exp, j| {
                        if (!std.mem.eql(u8, ast.tokenSlice(@intCast(t + j)), exp)) { m = false; break; }
                    }
                    if (!m) continue;

                    const start_byte = starts[t];
                    const end_byte   = start_byte + ast.tokenSlice(@intCast(t)).len;
                    const prefix = source[0..start_byte];
                    const suffix = source[end_byte..source.len];

                    var ms = std.ArrayList(u8).empty;
                    try ms.appendSlice(allocator, prefix);
                    try ms.appendSlice(allocator, p.replacement);
                    try ms.appendSlice(allocator, suffix);

                    var fbuf: [64]u8 = undefined;
                    const fname = try std.fmt.bufPrintZ(&fbuf, "tmp/mutant_{d}.zig", .{target_count});
                    const fp = std.c.fopen(fname, "w") orelse return error.CreateFileFailed;
                    _ = std.c.fwrite(ms.items.ptr, 1, ms.items.len, fp);
                    _ = std.c.fclose(fp);
                    ms.deinit(allocator);

                    std.debug.print("[GENERIC FAULT INJECTED] {s}: {s} -> {s}\n",
                        .{ cls.name, p.tokens[0], p.replacement });

                    target_count += 1;
                    found = true;
                    break;
                }
            }
        }
    }
    
    std.debug.print("\nPhase 1, 2, & 3 Complete. Generated {d} biological & generic mutants in tmp/.\n", .{target_count});

    // ---------- Phase 3B: Compile once + TCE filter ----------

    const fp_base = std.c.fopen("tmp/baseline.zig", "w") orelse return error.CreateFileFailed;
    _ = std.c.fwrite(source.ptr, 1, source.len, fp_base);
    _ = std.c.fclose(fp_base);

    _ = system("zig build-obj -lc -O Debug tmp/baseline.zig -femit-bin=tmp/baseline.o 2>/dev/null");
    const baseline_hash = try getFileHash("tmp/baseline.o");

    var compiled = std.ArrayList(usize).empty;
    defer compiled.deinit(allocator);

    var equivalent_count: usize = 0;
    var invalid_count: usize = 0;

    std.debug.print("\n[TCE FILTER] Compiling {d} mutants at -O Debug...\n", .{target_count});

    var m_idx: usize = 0;
    while (m_idx < target_count) : (m_idx += 1) {
        var cmd_buf: [512]u8 = undefined;

        const obj_cmd = try std.fmt.bufPrintZ(&cmd_buf,
            "zig build-obj -lc -O Debug tmp/mutant_{d}.zig -femit-bin=tmp/mutant_{d}.o 2>/dev/null",
            .{ m_idx, m_idx });
        _ = system(obj_cmd);

        var obj_path_buf: [64]u8 = undefined;
        const obj_path = try std.fmt.bufPrintZ(&obj_path_buf, "tmp/mutant_{d}.o", .{m_idx});

        const m_hash = getFileHash(obj_path) catch |err| {
            if (err == error.FileOpenError) {
                std.debug.print("  Mutant {d}: [INVALID] build failed\n", .{m_idx});
                invalid_count += 1;
                continue;
            }
            return err;
        };
        if (std.mem.eql(u8, &baseline_hash, &m_hash)) {
            std.debug.print("  Mutant {d}: [EQUIVALENT]\n", .{m_idx});
            equivalent_count += 1;
            continue;
        }

        const exe_cmd = try std.fmt.bufPrintZ(&cmd_buf,
            "zig build-exe -lc tmp/mutant_{d}.zig -femit-bin=tmp/mutant_exe_{d} 2>/dev/null",
            .{ m_idx, m_idx });
        if (system(exe_cmd) != 0) {
            std.debug.print("  Mutant {d}: [INVALID] build failed\n", .{m_idx});
            invalid_count += 1;
            continue;
        }

        try compiled.append(allocator, m_idx);
    }

    std.debug.print("\n[done] {d} valid, {d} equivalent, {d} invalid\n",
        .{ compiled.items.len, equivalent_count, invalid_count });

    // --- Compile the unmutated baseline as a runnable exe ---
    _ = system("cp tmp/baseline.zig src/sandbox_safe.zig.tmp");
    _ = system("cp tmp/baseline.zig tmp/sandbox_safe_baseline.zig");
    _ = system("zig build-exe -lc tmp/sandbox_safe_baseline.zig -femit-bin=tmp/sandbox_safe_baseline 2>/dev/null");

    // ---------- Phase 4 & 5: run each compiled mutant across all domains ----------

    const mutant_killed = try allocator.alloc(bool, target_count);
    defer allocator.free(mutant_killed);
    @memset(mutant_killed, false);

    const test_killed = try allocator.alloc(bool, target_count);
    defer allocator.free(test_killed);
    @memset(test_killed, false);

    std.debug.print("\n[TEST ORACLE] Running zig test on each valid mutant...\n", .{});
    for (compiled.items) |cm| {
        var cmd_buf: [512]u8 = undefined;
        const test_cmd = try std.fmt.bufPrintZ(&cmd_buf,
            "zig test tmp/mutant_{d}.zig -lc 2>/dev/null", .{cm});
        const rc = system(test_cmd);
        if (rc != 0) {
            test_killed[cm] = true;
            std.debug.print("  Mutant {d}: [TEST-KILLED]\n", .{cm});
        } else {
            std.debug.print("  Mutant {d}: [TEST-SURVIVED]\n", .{cm});
        }
    }

    for (1..61) |domain_id| {
        std.debug.print("\n=== Domain {d} ===\n", .{domain_id});

        var packet = MuzeIpcPacket{
            .magic_seed   = 0x5BD1E995,
            .domain_id    = @intCast(domain_id),
            .payload_f64_1 = 0,
            .payload_f64_2 = 0,
            .payload_u64   = 0,
        };
        const fp_out = std.c.fopen("tmp/payload.bin", "wb") orelse return error.CreatePayloadFailed;
        _ = std.c.fwrite(std.mem.asBytes(&packet).ptr, 1, @sizeOf(MuzeIpcPacket), fp_out);
        _ = std.c.fclose(fp_out);

        // --- Baseline run (unmutated) for this domain ---
        var baseline_result: MuzeIpcPacket = std.mem.zeroes(MuzeIpcPacket);
        var baseline_ok = false;
        {
            var b_child = try std.process.spawn(init.io, .{
                .argv = &[_][]const u8{ "sh", "-c", "exec ./tmp/sandbox_safe_baseline < tmp/payload.bin > tmp/baseline_result.bin 2>/dev/null" },
            });
            const b_pid: std.posix.pid_t = @intCast(b_child.id.?);
            var b_elapsed: u64 = 0;
            var b_term_status: ?c_int = null;
            var b_poll_fds: [0]std.posix.pollfd = undefined;
            while (b_elapsed < 2000) : (b_elapsed += 50) {
                var b_status: c_int = 0;
                const b_res = std.c.waitpid(b_pid, &b_status, std.c.W.NOHANG);
                if (b_res > 0) {
                    b_term_status = b_status;
                    break;
                }
                _ = std.posix.poll(&b_poll_fds, 50) catch {};
            }
            if (b_term_status == null) {
                b_child.kill(init.io);
            } else {
                const rc_base = @as(u32, @bitCast(b_term_status.?));
                if (std.posix.W.IFEXITED(rc_base) and std.posix.W.EXITSTATUS(rc_base) == 0) {
                    const fp_b = std.c.fopen("tmp/baseline_result.bin", "rb");
                    if (fp_b != null) {
                        _ = std.c.fread(std.mem.asBytes(&baseline_result).ptr, 1, @sizeOf(MuzeIpcPacket), fp_b.?);
                        _ = std.c.fclose(fp_b.?);
                        baseline_ok = true;
                    }
                }
            }
        }
        if (!baseline_ok) {
            std.debug.print("  [SKIP] baseline failed for domain {d}\n", .{domain_id});
            continue;
        }

        for (compiled.items) |cm| {
            var sh_cmd_buf: [512]u8 = undefined;
            const sh_cmd = try std.fmt.bufPrint(&sh_cmd_buf,
                "exec ./tmp/mutant_exe_{d} < tmp/payload.bin > tmp/result.bin 2>/dev/null",
                .{cm});

            var child = try std.process.spawn(init.io, .{
                .argv = &[_][]const u8{ "sh", "-c", sh_cmd },
            });

            const pid: std.posix.pid_t = @intCast(child.id.?);
            var elapsed: u64 = 0;
            var term_status: ?c_int = null;
            var poll_fds: [0]std.posix.pollfd = undefined;

            while (elapsed < 2000) : (elapsed += 50) {
                var status: c_int = 0;
                const res = std.c.waitpid(pid, &status, std.c.W.NOHANG);
                if (res > 0) {
                    term_status = status;
                    break;
                }
                _ = std.posix.poll(&poll_fds, 50) catch {};
            }

            if (term_status == null) {
                child.kill(init.io);
                std.debug.print("  Mutant {d}: [KILLED] timeout\n", .{cm});
                mutant_killed[cm] = true;
            } else {
                const rc = @as(u32, @bitCast(term_status.?));
                if (std.posix.W.IFSIGNALED(rc)) {
                    const sig = @intFromEnum(std.posix.W.TERMSIG(rc));
                    std.debug.print("  Mutant {d}: [KILLED] signal {d}\n", .{ cm, sig });
                    mutant_killed[cm] = true;
                } else if (std.posix.W.IFEXITED(rc)) {
                    const code = std.posix.W.EXITSTATUS(rc);
                    if (code != 0) {
                        std.debug.print("  Mutant {d}: [KILLED] exit {d}\n", .{ cm, code });
                        mutant_killed[cm] = true;
                    } else {
                        // Exit 0 — compare output packet to baseline.
                        var mres: MuzeIpcPacket = std.mem.zeroes(MuzeIpcPacket);
                        const fp_m = std.c.fopen("tmp/result.bin", "rb");
                        if (fp_m == null) {
                            std.debug.print("  Mutant {d}: [INVALID] no output\n", .{cm});
                            continue;
                        }
                        _ = std.c.fread(std.mem.asBytes(&mres).ptr, 1, @sizeOf(MuzeIpcPacket), fp_m.?);
                        _ = std.c.fclose(fp_m.?);

                        const same = std.meta.eql(mres, baseline_result);
                        if (same) {
                            std.debug.print("  Mutant {d}: [SURVIVED]\n", .{cm});
                        } else {
                            std.debug.print("  Mutant {d}: [KILLED] output differs\n", .{cm});
                            mutant_killed[cm] = true;
                        }
                    }
                }
            }
        }
    }

    // --- Determine class boundary ---
    // Bio mutants are generated first; generic mutants append afterward.
    // Verify by counting [BIOLOGICAL FAULT INJECTED] lines in the log.
    const BIO_COUNT: usize = 65;

    var bio_total: usize = 0;
    var gen_total: usize = 0;
    var bio_diff_killed: usize = 0;
    var bio_test_killed: usize = 0;
    var gen_diff_killed: usize = 0;
    var gen_test_killed: usize = 0;

    for (compiled.items) |cm| {
        const d = mutant_killed[cm];
        const t = test_killed[cm];

        if (cm < BIO_COUNT) {
            bio_total += 1;
            if (d) bio_diff_killed += 1;
            if (t) bio_test_killed += 1;
        } else {
            gen_total += 1;
            if (d) gen_diff_killed += 1;
            if (t) gen_test_killed += 1;
        }
    }

    const bf: f64 = @floatFromInt(bio_total);
    const gf: f64 = @floatFromInt(gen_total);

    var strong_kill: usize = 0;
    var silent_to_tests: usize = 0;
    var assertion_only: usize = 0;
    var full_escape: usize = 0;

    for (compiled.items) |cm| {
        const d = mutant_killed[cm];
        const t = test_killed[cm];
        if (d and t) {
            strong_kill += 1;
        } else if (d and !t) {
            silent_to_tests += 1;
        } else if (!d and t) {
            assertion_only += 1;
        } else {
            full_escape += 1;
        }
    }

    std.debug.print(
        "\n=== PHASE 2: 2x2 CLASSIFICATION ===\n" ++
        "STRONG_KILL: {d}\n" ++
        "SILENT_TO_TESTS: {d}\n" ++
        "ASSERTION_ONLY: {d}\n" ++
        "FULL_ESCAPE: {d}\n",
        .{ strong_kill, silent_to_tests, assertion_only, full_escape }
    );
    std.debug.print(
        "\n=== FOUR-WAY SCORE SPLIT ===\n" ++
        "MS_bio_diff = {d}/{d} = {d:.2}%\n" ++
        "MS_bio_test = {d}/{d} = {d:.2}%\n" ++
        "MS_gen_diff = {d}/{d} = {d:.2}%\n" ++
        "MS_gen_test = {d}/{d} = {d:.2}%\n" ++
        "\n=== HYPOTHESIS H1: MS_bio_test < MS_gen_test ===\n" ++
        "{s}\n",
        .{
            bio_diff_killed, bio_total, 100.0 * @as(f64, @floatFromInt(bio_diff_killed)) / bf,
            bio_test_killed, bio_total, 100.0 * @as(f64, @floatFromInt(bio_test_killed)) / bf,
            gen_diff_killed, gen_total, 100.0 * @as(f64, @floatFromInt(gen_diff_killed)) / gf,
            gen_test_killed, gen_total, 100.0 * @as(f64, @floatFromInt(gen_test_killed)) / gf,
            if (bio_test_killed * gen_total < gen_test_killed * bio_total)
                "CONFIRMED (MS_bio_test < MS_gen_test)"
            else
                "NOT CONFIRMED",
        },
    );
}

// IPC ABI Definition
pub const MuzeIpcPacket = extern struct {
    magic_seed: u32,
    domain_id: u8,
    payload_f64_1: f64,
    payload_f64_2: f64,
    payload_u64: u64,
};

extern "c" fn system(cmd: [*:0]const u8) c_int;

fn getFileHash(path: [*:0]const u8) ![32]u8 {
    const fp = std.c.fopen(path, "rb") orelse return error.FileOpenError;
    defer _ = std.c.fclose(fp);
    var hasher = std.crypto.hash.sha2.Sha256.init(.{});
    var buf: [4096]u8 = undefined;
    while (true) {
        const bytes_read = std.c.fread(&buf, 1, buf.len, fp);
        if (bytes_read == 0) break;
        hasher.update(buf[0..bytes_read]);
    }
    var final_hash: [32]u8 = undefined;
    hasher.final(&final_hash);
    return final_hash;
}
