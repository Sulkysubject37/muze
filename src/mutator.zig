const std = @import("std");

/// MUZE: Mutator Utility for Zero-memory-fault Evaluations
/// Phase 1 & 2: Ingests the Sandbox and Parses the AST for targets.
pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    std.debug.print("Initializing MUZE AST Parser...\n", .{});

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
        .{ .name = "Reverse Complement Bias", .target_sequence = &[_][]const u8{"~", "base"}, .mutate_idx = 0, .replacement = "" },
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
    };

    var target_count: usize = 0;
    
    // AST Traversal: Hunt for biological structural faults
    var i: usize = 0;
    while (i < ast.tokens.len) : (i += 1) {
        for (bio_mutators) |mut| {
            if (i + mut.target_sequence.len >= ast.tokens.len) continue;
            
            var match = true;
            for (mut.target_sequence, 0..) |expected_tok, j| {
                if (!std.mem.eql(u8, ast.tokenSlice(@intCast(i + j)), expected_tok)) {
                    match = false;
                    break;
                }
            }
            
            if (match) {
                const mutate_token_idx = i + mut.mutate_idx;
                const start_byte = ast.tokens.items(.start)[mutate_token_idx];
                const end_byte = start_byte + ast.tokenSlice(@intCast(mutate_token_idx)).len;
                
                std.debug.print("[BIOLOGICAL FAULT INJECTED] {s}\n   -> Pattern: ", .{mut.name});
                for (mut.target_sequence) |t| { std.debug.print("{s} ", .{t}); }
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
                i += mut.target_sequence.len; // Skip ahead to avoid overlapping matches
                break;
            }
        }
    }

    
    std.debug.print("\nPhase 1, 2, & 3 Complete. Generated {d} biological mutants in tmp/.\n", .{target_count});

    // ================================================================
    // Phase 3B: Trivial Compiler Equivalence (TCE) Filter
    // ================================================================
    std.debug.print("\n[TCE FILTER] Establishing LLVM-IR Machine Code Baseline...\n", .{});
    const fp_base = std.c.fopen("tmp/baseline.zig", "w") orelse return error.CreateFileFailed;
    _ = std.c.fwrite(source.ptr, 1, source.len, fp_base);
    _ = std.c.fclose(fp_base);
    
    _ = system("zig build-obj -lc -O ReleaseFast -fstrip tmp/baseline.zig -femit-bin=tmp/baseline.o 2>/dev/null");
    const baseline_hash = try getFileHash("tmp/baseline.o");
    
    // ================================================================
    // Phase 4: The POSIX IPC Supervisor
    // ================================================================
    std.debug.print("\n[SUPERVISOR] Commencing Differential POSIX Executions...\n", .{});
    
    // Test all 5 domains sequentially inside the supervisor
    for (1..12) |domain_id| {
        std.debug.print("\n=== Testing Domain {d} ===\n", .{domain_id});
        var packet = MuzeIpcPacket{
            .magic_seed = 0x5BD1E995,
            .domain_id = @intCast(domain_id),
            .payload_f64_1 = 0,
            .payload_f64_2 = 0,
            .payload_u64 = 0,
        };
        
        // Write strict binary ABI struct to tmp/payload.bin
        const fp_out = std.c.fopen("tmp/payload.bin", "wb") orelse return error.CreatePayloadFailed;
        _ = std.c.fwrite(std.mem.asBytes(&packet).ptr, 1, @sizeOf(MuzeIpcPacket), fp_out);
        _ = std.c.fclose(fp_out);

        var m_idx: usize = 0;
        while (m_idx < target_count) : (m_idx += 1) {
            var cmd_buf: [256]u8 = undefined;
            
            // Phase 3B Check: Compile mutant to stripped object and hash
            const obj_cmd = try std.fmt.bufPrintZ(&cmd_buf, "zig build-obj -lc -O ReleaseFast -fstrip tmp/mutant_{d}.zig -femit-bin=tmp/mutant_{d}.o 2>/dev/null", .{m_idx, m_idx});
            _ = system(obj_cmd);
            
            var mutant_obj_path: [64]u8 = undefined;
            const obj_path = try std.fmt.bufPrintZ(&mutant_obj_path, "tmp/mutant_{d}.o", .{m_idx});
            
            const mutant_hash = try getFileHash(obj_path);
            if (std.mem.eql(u8, &baseline_hash, &mutant_hash)) {
                std.debug.print("  -> Mutant {d}: [DISCARDED] TCE Ghost Mutant (Optimized out by compiler)\n", .{m_idx});
                continue;
            }

            // Compile the Mutant to Executable
            const build_cmd = try std.fmt.bufPrintZ(&cmd_buf, "zig build-exe -lc tmp/mutant_{d}.zig -femit-bin=tmp/mutant_exe 2>/dev/null", .{m_idx});
            _ = system(build_cmd);

        // Execute via Pipeline Redirection (No deadlocks, ultra-robust)
        const run_cmd = "perl -e 'alarm 1; exec @ARGV' ./tmp/mutant_exe < tmp/payload.bin > tmp/result.bin 2>/dev/null";
        const rc = @as(u32, @bitCast(system(run_cmd)));
        
        // ================================================================
        // Phase 5: POSIX Signal Autopsy & Classification
        // ================================================================
        std.debug.print("  -> Mutant {d}: ", .{m_idx});
        if (std.posix.W.IFSIGNALED(rc)) {
            const sig = @intFromEnum(std.posix.W.TERMSIG(rc));
            if (sig == 11) {
                std.debug.print("[KILLED] Memory Fault (SIGSEGV)\n", .{});
            } else if (sig == 8) {
                std.debug.print("[KILLED] Math Fault (SIGFPE)\n", .{});
            } else if (sig == 9 or sig == 15) {
                std.debug.print("[KILLED] Topological Loop (SIGKILL/SIGTERM Timeout)\n", .{});
            } else {
                std.debug.print("[KILLED] POSIX Signal {d}\n", .{sig});
            }
        } else if (std.posix.W.IFEXITED(rc)) {
            const exit_code = std.posix.W.EXITSTATUS(rc);
            if (exit_code == 0) {
                // Autopsy the silent failure by reading the result
                var result: MuzeIpcPacket = undefined;
                const fp_in = std.c.fopen("tmp/result.bin", "rb");
                if (fp_in != null) {
                    _ = std.c.fread(std.mem.asBytes(&result).ptr, 1, @sizeOf(MuzeIpcPacket), fp_in.?);
                    _ = std.c.fclose(fp_in.?);
                    std.debug.print("[SURVIVED] Silent Biological Failure! (Result: {d})\n", .{result.payload_u64});
                } else {
                    std.debug.print("[?] Execution completed, but IPC result missing.\n", .{});
                }
            } else if (exit_code == 124 or exit_code == 142) {
                 std.debug.print("[KILLED] Watchdog Timeout (124)\n", .{});
            } else {
                std.debug.print("[KILLED] Exited with error code {d}\n", .{exit_code});
            }
        }
        }
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
