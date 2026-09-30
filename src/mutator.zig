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
                const tok_idx = i + j;
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
    
    std.debug.print("\nPhase 1, 2, & 3 Complete. Generated {d} biological mutants in tmp/.\n", .{target_count});

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

        const m_hash = try getFileHash(obj_path);
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

    for (1..24) |domain_id| {
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

    // --- Final tally: unique mutants only ---
    var killed_count: usize = 0;
    for (compiled.items) |cm| {
        if (mutant_killed[cm]) killed_count += 1;
    }

    const denom = compiled.items.len;
    if (denom > 0) {
        const score = 100.0 * @as(f64, @floatFromInt(killed_count)) / @as(f64, @floatFromInt(denom));
        std.debug.print(
            "\n=== MUTATION SCORE: {d:.2}% ({d} killed / {d} valid, {d} equivalent, {d} invalid) ===\n",
            .{ score, killed_count, denom, equivalent_count, invalid_count },
        );
    }
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
