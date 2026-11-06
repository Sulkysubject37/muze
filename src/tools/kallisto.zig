const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const ToolAdapter = @import("../runner/adapter.zig").ToolAdapter;
const classify = @import("../runner/classify.zig");
const sandbox = @import("../runner/sandbox.zig");

fn initWorker(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8, baseline_dir: []const u8) anyerror!void {
    const cmd = try std.fmt.allocPrint(alloc, "rm -rf {s} && mkdir -p {s} && cp -a {s}/. {s}/", .{ worker_dir, worker_dir, baseline_dir, worker_dir });
    defer alloc.free(cmd);
    _ = try sandbox.exec(alloc, io, cmd, ".", 120, "/dev/null", "/dev/null");
}

fn compileMutant(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8, worker_dir: []const u8) anyerror![]const u8 {
    var obj_buf: [256]u8 = undefined;
    const base_name = if (std.mem.lastIndexOfScalar(u8, file_path, '/')) |idx|
        file_path[idx + 1 ..]
    else
        file_path;

    const obj_file = std.fmt.bufPrint(&obj_buf, "build/src/CMakeFiles/kallisto.dir/{s}.o", .{base_name}) catch return error.CompileFailed;

    const compile_cmd = try std.fmt.allocPrint(
        alloc,
        "c++ -DCOMPILATION_ARCH=OFF -DENABLE_AVX2=OFF -DMAX_KMER_SIZE=32 -DNO_HTSLIB=ON -Iext/bifrost/build/src -Iext/bifrost/src -Isrc -O3 -DNDEBUG -std=c++17 -arch arm64 -Wno-deprecated-declarations -Wno-subobject-linkage -ffile-prefix-map={s}=. -c -o {s}.tmp {s} && mv -f {s}.tmp {s}",
        .{ worker_dir, obj_file, file_path, obj_file, obj_file },
    );
    defer alloc.free(compile_cmd);

    const res = try sandbox.exec(alloc, io, compile_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;

    return std.fmt.allocPrint(alloc, "{s}/{s}", .{ worker_dir, obj_file });
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const link_cmd = 
        \\c++ -O3 -DNDEBUG -arch arm64 -Wl,-search_paths_first -Wl,-headerpad_max_install_names \
        \\build/src/CMakeFiles/kallisto.dir/main.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/BUSData.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/BUSTools.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/Bootstrap.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/Fusion.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/GeneModel.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/H5Writer.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/KmerIndex.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/MinCollector.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/PlaintextWriter.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/ProcessReads.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/PseudoBam.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/common.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/h5utils.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/hash.cpp.o \
        \\build/src/CMakeFiles/kallisto.dir/weights.cpp.o \
        \\-o build/src/kallisto \
        \\build/src/libkallisto_core.a \
        \\-lpthread \
        \\ext/bifrost/build/src/libbifrost.a \
        \\-lz && codesign -s - -f build/src/kallisto
    ;
    const res = try sandbox.exec(alloc, io, link_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const run_cmd = "rm -rf out_quant && ./build/src/kallisto quant -i test/transcripts.idx -o out_quant test/reads_1.fastq.gz test/reads_2.fastq.gz >/dev/null 2>&1";
    const res = try sandbox.exec(alloc, io, run_cmd, worker_dir, 20, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const verify_cmd = 
        \\awk '
        \\$1 == "ENST00000040584.5" { if ($4 >= 4000 && $4 <= 4500 && $5 >= 450000 && $5 <= 500000) c1++ }
        \\$1 == "ENST00000282507.7" { if ($4 >= 1400 && $4 <= 1800 && $5 >= 120000 && $5 <= 160000) c2++ }
        \\$1 == "ENST00000243103.3" { if ($4 >= 800  && $4 <= 1100 && $5 >= 50000  && $5 <= 65000)  c3++ }
        \\END {
        \\  if (c1 == 1 && c2 == 1 && c3 == 1) exit 0;
        \\  exit 1;
        \\}' out_quant/abundance.tsv
    ;
    const vres = try sandbox.exec(alloc, io, verify_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (vres.exit_code != 0) return .killed;

    const info_cmd = 
        \\awk '
        \\$1 ~ /"n_pseudoaligned":/ {
        \\  val = $2;
        \\  gsub(/[^0-9]/, "", val);
        \\  if (val >= 9000 && val <= 9800) ok++
        \\}
        \\END {
        \\  if (ok == 1) exit 0;
        \\  exit 1;
        \\}' out_quant/run_info.json
    ;
    const ires = try sandbox.exec(alloc, io, info_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (ires.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "kallisto",
    .source_root = "external/kallisto",
    .lang = .cpp,
    .source_dirs = &.{
        "src/KmerIndex.cpp",
        "src/MinCollector.cpp",
        "src/ProcessReads.cpp",
        "src/weights.cpp",
        "src/Bootstrap.cpp",
        "src/GeneModel.cpp",
        "src/common.cpp",
    },
    .skip_dirs = &.{ "ext", "docs", "test", "unit_tests", "func_tests" },
    .extensions = &.{ ".cpp", ".cc", ".c" },
    .max_workers = 2,
    .baseline_build_cmd = "mkdir -p build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_AVX2=OFF -DCOMPILATION_ARCH=OFF && make -j4",
    .build_timeout_s = 600,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
