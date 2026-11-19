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
    const dot_idx = std.mem.lastIndexOfScalar(u8, file_path, '.') orelse return error.CompileFailed;
    const base_without_ext = file_path[0..dot_idx];
    const obj_file = std.fmt.bufPrint(&obj_buf, "{s}.o", .{base_without_ext}) catch return error.CompileFailed;

    const compile_cmd = try std.fmt.allocPrint(
        alloc,
        "c++ -DHAVE_CONFIG_H -I. -I./include -Wall -Wnon-virtual-dtor -I/opt/homebrew/Cellar/htslib/1.24/include -std=c++11 -g -O2 -Wno-vla-cxx-extension -ffile-prefix-map={s}=. -c -o {s}.tmp {s} && mv -f {s}.tmp {s}",
        .{ worker_dir, obj_file, file_path, obj_file, obj_file },
    );
    defer alloc.free(compile_cmd);

    const res = try sandbox.exec(alloc, io, compile_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;

    return std.fmt.allocPrint(alloc, "{s}/{s}", .{ worker_dir, obj_file });
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const link_cmd = 
        \\c++ -std=c++11 -g -O2 -o bin/.libs/jellyfish \
        \\sub_commands/jellyfish.o sub_commands/count_main.o sub_commands/info_main.o \
        \\sub_commands/dump_main.o sub_commands/histo_main.o sub_commands/stats_main.o \
        \\sub_commands/merge_main.o sub_commands/bc_main.o sub_commands/query_main.o \
        \\sub_commands/cite_main.o sub_commands/mem_main.o jellyfish/merge_files.o \
        \\jellyfish/mersenne.o jellyfish/dbg.o jellyfish/backtrace.o \
        \\lib/allocators_mmap.o lib/generator_manager.o lib/int128.o \
        \\lib/jsoncpp.o lib/mer_dna.o lib/misc.o lib/rectangular_binary_matrix.o \
        \\lib/storage.o lib/thread_exec.o lib/time.o \
        \\-L/opt/homebrew/Cellar/htslib/1.24/lib -lhts -lpthread \
        \\&& cp -f bin/.libs/jellyfish bin/jellyfish \
        \\&& codesign -s - -f bin/.libs/jellyfish
    ;
    const res = try sandbox.exec(alloc, io, link_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const count_cmd = "rm -rf test_eval && mkdir -p test_eval && ./bin/.libs/jellyfish count -m 21 -s 10M -C -o test_eval/mer_counts.jf tests-data/seq1m_0.fa >/dev/null 2>&1";
    const res = try sandbox.exec(alloc, io, count_cmd, worker_dir, 20, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const stats_cmd = "./bin/.libs/jellyfish stats test_eval/mer_counts.jf > test_eval/stats.txt 2>&1";
    const sres = try sandbox.exec(alloc, io, stats_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (sres.exit_code != 0) return .killed;

    const verify_stats = 
        \\awk '
        \\$1 == "Distinct:" { if ($2 == 999980) d_ok++ }
        \\$1 == "Total:"    { if ($2 == 999980) t_ok++ }
        \\END {
        \\  if (d_ok == 1 && t_ok == 1) exit 0;
        \\  exit 1;
        \\}' test_eval/stats.txt
    ;
    const vres = try sandbox.exec(alloc, io, verify_stats, worker_dir, 10, "/dev/null", "/dev/null");
    if (vres.exit_code != 0) return .killed;

    const histo_cmd = "./bin/.libs/jellyfish histo test_eval/mer_counts.jf > test_eval/histo.txt 2>&1";
    const hres = try sandbox.exec(alloc, io, histo_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (hres.exit_code != 0) return .killed;

    const verify_histo = 
        \\awk '
        \\$1 == "1" && $2 == "999980" { h_ok++ }
        \\END {
        \\  if (h_ok == 1) exit 0;
        \\  exit 1;
        \\}' test_eval/histo.txt
    ;
    const vhres = try sandbox.exec(alloc, io, verify_histo, worker_dir, 10, "/dev/null", "/dev/null");
    if (vhres.exit_code != 0) return .killed;

    const query_cmd = "./bin/.libs/jellyfish query test_eval/mer_counts.jf TGCTTTGTCTACCAGCCGGGA > test_eval/query.txt 2>&1";
    const qres = try sandbox.exec(alloc, io, query_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (qres.exit_code != 0) return .killed;

    const verify_query = 
        \\awk '
        \\$1 == "TCCCGGCTGGTAGACAAAGCA" && $2 == "1" { q_ok++ }
        \\END {
        \\  if (q_ok == 1) exit 0;
        \\  exit 1;
        \\}' test_eval/query.txt
    ;
    const vqres = try sandbox.exec(alloc, io, verify_query, worker_dir, 10, "/dev/null", "/dev/null");
    if (vqres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "jellyfish",
    .source_root = "external/jellyfish",
    .lang = .cpp,
    .source_dirs = &.{
        "sub_commands/count_main.cc",
        "sub_commands/dump_main.cc",
        "sub_commands/histo_main.cc",
        "sub_commands/stats_main.cc",
        "sub_commands/query_main.cc",
        "sub_commands/bc_main.cc",
        "sub_commands/jellyfish.cc",
        "sub_commands/cite_main.cc",
        "sub_commands/info_main.cc",
        "sub_commands/mem_main.cc",
        "sub_commands/merge_main.cc",
        "lib/rectangular_binary_matrix.cc",
        "lib/allocators_mmap.cc",
        "lib/generator_manager.cc",
        "lib/jsoncpp.cpp",
        "lib/int128.cc",
        "lib/misc.cc",
        "lib/storage.cc",
        "lib/thread_exec.cc",
        "jellyfish/merge_files.cc",
        "jellyfish/mersenne.cpp",
        "jellyfish/dbg.cc",
        "jellyfish/backtrace.cc",
    },
    .skip_dirs = &.{ "unit_tests", "tests", "doc", "examples", "swig", ".deps" },
    .extensions = &.{ ".cc", ".cpp" },
    .max_workers = 2,
    .baseline_build_cmd = "mkdir -p .libs bin/.libs && cd .libs && ln -sf libjellyfish-2.0.2.dylib libjellyfish-2.0.dylib && cd .. && c++ -std=c++11 -g -O2 -o bin/.libs/jellyfish sub_commands/jellyfish.o sub_commands/count_main.o sub_commands/info_main.o sub_commands/dump_main.o sub_commands/histo_main.o sub_commands/stats_main.o sub_commands/merge_main.o sub_commands/bc_main.o sub_commands/query_main.o sub_commands/cite_main.o sub_commands/mem_main.o jellyfish/merge_files.o jellyfish/mersenne.o jellyfish/dbg.o jellyfish/backtrace.o lib/allocators_mmap.o lib/generator_manager.o lib/int128.o lib/jsoncpp.o lib/mer_dna.o lib/misc.o lib/rectangular_binary_matrix.o lib/storage.o lib/thread_exec.o lib/time.o -L/opt/homebrew/Cellar/htslib/1.24/lib -lhts -lpthread && cp -f bin/.libs/jellyfish bin/jellyfish && codesign -s - -f bin/.libs/jellyfish",
    .build_timeout_s = 600,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
