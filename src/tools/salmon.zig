const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const ToolAdapter = @import("../runner/adapter.zig").ToolAdapter;
const classify = @import("../runner/classify.zig");
const sandbox = @import("../runner/sandbox.zig");

fn initWorker(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8, baseline_dir: []const u8) anyerror!void {
    _ = baseline_dir;
    const cmd = try std.fmt.allocPrint(
        alloc,
        "rm -rf {s} && mkdir -p $(dirname {s}) && ln -s /Users/sulky/Downloads/off_proj/sem_iii/salmon-sourcecode {s}",
        .{ worker_dir, worker_dir, worker_dir },
    );
    defer alloc.free(cmd);
    _ = try sandbox.exec(alloc, io, cmd, ".", 60, "/dev/null", "/dev/null");
}

fn compileMutant(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8, worker_dir: []const u8) anyerror![]const u8 {
    _ = file_path;
    const compile_cmd = "cargo build -p salmon-cli";
    const res = try sandbox.exec(alloc, io, compile_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;

    const bin_path = try std.fmt.allocPrint(alloc, "{s}/target/debug/salmon", .{worker_dir});
    return bin_path;
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    _ = alloc;
    _ = io;
    _ = worker_dir;
    return true;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const quant_cmd = "rm -rf eval_quant && ./target/debug/salmon quant -i sample_data/salmon_index -l A -1 sample_data/reads_1.fastq -2 sample_data/reads_2.fastq -o eval_quant >/dev/null 2>&1";
    const res = try sandbox.exec(alloc, io, quant_cmd, worker_dir, 30, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const check_cmd = "test -s eval_quant/quant.sf && test $(wc -l < eval_quant/quant.sf | tr -d ' ') -eq 16 && grep -q 'NM_022658[[:space:]]*2288[[:space:]]*2109' eval_quant/quant.sf && grep -q '4881' eval_quant/quant.sf";
    const cres = try sandbox.exec(alloc, io, check_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (cres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "salmon",
    .lang = .rust,
    .source_root = "external/salmon",
    .source_dirs = &.{
        "crates/salmon-infer/src/online.rs",
        "crates/salmon-infer/src/packed.rs",
        "crates/salmon-infer/src/daarem.rs",
        "crates/salmon-infer/src/uncertainty.rs",
        "crates/salmon-model/src/fld.rs",
        "crates/salmon-model/src/seqbias.rs",
        "crates/salmon-model/src/gcbias.rs",
        "crates/salmon-model/src/posbias.rs",
        "crates/salmon-model/src/bias.rs",
        "crates/salmon-model/src/spline.rs",
        "crates/salmon-model/src/libdetect.rs",
        "crates/salmon-eqclass/src/lib.rs",
        "crates/salmon-core/src/libtype.rs",
        "crates/salmon-core/src/math.rs",
        "crates/salmon-quant/src/output.rs",
        "crates/salmon-quant/src/processor.rs",
    },
    .skip_dirs = &.{ "target", "tests", "examples", "benches" },
    .extensions = &.{ ".rs" },
    .max_workers = 1,
    .baseline_build_cmd = "test -f target/debug/salmon",
    .build_timeout_s = 600,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
