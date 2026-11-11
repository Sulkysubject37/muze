const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const ToolAdapter = @import("../runner/adapter.zig").ToolAdapter;
const classify = @import("../runner/classify.zig");
const sandbox = @import("../runner/sandbox.zig");

fn initWorker(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8, baseline_dir: []const u8) anyerror!void {
    const cmd = try std.fmt.allocPrint(alloc, "rm -rf {s} && mkdir -p {s} && cp -a {s}/. {s}/", .{ worker_dir, worker_dir, baseline_dir, worker_dir });
    defer alloc.free(cmd);
    _ = try sandbox.exec(alloc, io, cmd, ".", 180, "/dev/null", "/dev/null");
}

fn compileMutant(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8, worker_dir: []const u8) anyerror![]const u8 {
    var obj_buf: [512]u8 = undefined;
    const rel_path = if (std.mem.startsWith(u8, file_path, "src/"))
        file_path[4..]
    else
        file_path;

    const obj_file = std.fmt.bufPrint(&obj_buf, "build/src/CMakeFiles/foldseek-framework.dir/{s}.o", .{rel_path}) catch return error.CompileFailed;

    const compile_cmd = try std.fmt.allocPrint(
        alloc,
        "/usr/bin/c++ -c -O3 -DNDEBUG -arch arm64 -fsigned-char -mcpu=native -DAVX2 -D_GNU_SOURCE=1 -D__APPLE_API_STRICT_CONFORMANCE -std=c++1y -pedantic -Wall -Wextra -Wdisabled-optimization -fno-exceptions -Xclang -fopenmp -include cstdint -DENABLE_IPS4O=1 -DGGML_USE_CPU -DGGML_USE_METAL -DHAVE_BZLIB=1 -DHAVE_POSIX_MADVISE=1 -DHAVE_PROSTT5=1 -DHAVE_STRUCTTY=1 -DHAVE_ZLIB=1 -DOPENMP=1 -D_USE_MATH_DEFINES=1 -Ilib -Ilib/3di -Ilib/pulchra -Ilib/kerasify -Isrc/commons -Ilib/mmseqs/lib/block-aligner/c -Ilib/mmseqs/lib/zstd/lib -Ilib/mmseqs/lib/tinyexpr -Ilib/mmseqs/lib/microtar -Ilib/mmseqs/lib/tantan -Ilib/mmseqs/lib/simde -Ilib/mmseqs/lib -Ilib/mmseqs/lib/simd -Ilib/mmseqs/lib/alp -Ilib/mmseqs/lib/ksw2 -Ilib/mmseqs/lib/xxhash -Ilib/mmseqs/lib/ips4o -Ibuild/generated -Ibuild/lib/mmseqs/generated -Ilib/mmseqs/src/alignment -Ilib/mmseqs/src/clustering -Ilib/mmseqs/src/commons -Ilib/mmseqs/src/multihit -Ilib/mmseqs/src/prefiltering -Ilib/mmseqs/src/linclust -Ilib/mmseqs/src/taxonomy -Ilib/mmseqs/src/util -Ilib/mmseqs/src/. -I/opt/homebrew/opt/libomp/include -Ilib/structty/include -Ilib/structty/src/utils -Ilib/structty/src/structure -Ilib/structty/src/visualization -Ilib/structty/src/render -Ilib/structty/lib/stb -Ilib/prostt5/src/. -Ilib/prostt5/src/../include -Ilib/prostt5/ggml/src/../include -ffile-prefix-map={s}=. -o {s}.tmp {s} && mv -f {s}.tmp {s}",
        .{ worker_dir, obj_file, file_path, obj_file, obj_file },
    );
    defer alloc.free(compile_cmd);

    const res = try sandbox.exec(alloc, io, compile_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;

    return std.fmt.allocPrint(alloc, "{s}/{s}", .{ worker_dir, obj_file });
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const link_cmd = 
        \\ar rcs build/src/libfoldseek-framework.a build/src/CMakeFiles/foldseek-framework.dir/commons/*.o build/src/CMakeFiles/foldseek-framework.dir/strucclustutils/*.o build/src/CMakeFiles/foldseek-framework.dir/workflow/*.o build/src/CMakeFiles/foldseek-framework.dir/*.o 2>/dev/null; \
        \\/usr/bin/c++ -O3 -DNDEBUG -arch arm64 -Wl,-search_paths_first -Wl,-headerpad_max_install_names \
        \\-fsigned-char -mcpu=native -DAVX2 -D_GNU_SOURCE=1 -D__APPLE_API_STRICT_CONFORMANCE -std=c++1y \
        \\-pedantic -Wall -Wextra -Wdisabled-optimization -fno-exceptions -Xclang -fopenmp \
        \\build/src/CMakeFiles/foldseek.dir/foldseek.cpp.o -o build/src/foldseek \
        \\build/src/libfoldseek-framework.a build/src/version/libversion.a build/src/strucclustutils/libgemmiwrapper.a \
        \\build/lib/foldcomp/libfoldcomp.a build/lib/3di/lib3di.a build/lib/pulchra/libpulchra.a \
        \\build/lib/kerasify/libkerasify.a build/lib/tmalign/libtmalign.a build/lib/mmseqs/src/libmmseqs-framework.a \
        \\build/src/version/libversion.a build/lib/mmseqs/lib/tinyexpr/libtinyexpr.a \
        \\build/lib/mmseqs/lib/zstd/build/cmake/lib/libzstd.a build/lib/mmseqs/lib/microtar/libmicrotar.a \
        \\build/lib/mmseqs/lib/tantan/libtantan.a build/lib/mmseqs/libblock_aligner_c.a -lSystem -lc \
        \\/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib/libz.tbd \
        \\/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib/libbz2.tbd \
        \\/opt/homebrew/opt/libomp/lib/libomp.dylib build/lib/structty/libstructty.a \
        \\build/lib/structty/src/render/libstructty_render.a \
        \\/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib/libz.tbd build/src/libprostt5.a \
        \\build/lib/prostt5/src/libllama.a build/lib/prostt5/ggml/src/libggml.a \
        \\build/lib/prostt5/ggml/src/libggml-cpu.a -framework Accelerate \
        \\build/lib/prostt5/ggml/src/ggml-metal/libggml-metal.a build/lib/prostt5/ggml/src/libggml-base.a \
        \\-lm -framework Foundation -framework Metal -framework MetalKit \
        \\&& codesign -s - -f build/src/foldseek
    ;
    const res = try sandbox.exec(alloc, io, link_cmd, worker_dir, 60, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const search_cmd = "rm -rf test_eval && mkdir -p test_eval && ./build/src/foldseek easy-search example/d1asha_ example/ test_eval/res.m8 test_eval/tmp --format-output query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits,alntmscore >/dev/null 2>&1";
    const res = try sandbox.exec(alloc, io, search_cmd, worker_dir, 30, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const check_cmd = "test -s test_eval/res.m8 && test $(wc -l < test_eval/res.m8 | tr -d ' ') -eq 29 && grep -q '^d1asha_[[:space:]]*d1asha_[[:space:]]*1\\.000[[:space:]]*147' test_eval/res.m8";
    const cres = try sandbox.exec(alloc, io, check_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (cres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "foldseek",
    .lang = .cpp,
    .source_root = "external/foldseek",
    .source_dirs = &.{
        "src/commons/TMaligner.cpp",
        "src/commons/StructureSmithWaterman.cpp",
        "src/commons/LDDT.cpp",
        "src/commons/LocalParameters.cpp",
        "src/strucclustutils/tmalign.cpp",
        "src/strucclustutils/aln2tmscore.cpp",
        "src/strucclustutils/structcreatedb.cpp",
        "src/strucclustutils/structurealign.cpp",
        "src/strucclustutils/samplemulambda.cpp",
        "src/strucclustutils/structureconvertalis.cpp",
        "src/strucclustutils/structureto3didescriptor.cpp",
        "src/strucclustutils/structurerescorediagonal.cpp",
        "src/strucclustutils/convert2pdb.cpp",
        "src/strucclustutils/compressca.cpp",
        "src/workflow/StructureSearch.cpp",
        "src/workflow/EasyStructureSearch.cpp",
        "src/workflow/StructureCluster.cpp",
        "src/workflow/StructureIndex.cpp",
        "src/FoldseekBase.cpp",
    },
    .skip_dirs = &.{ "unit_tests", "tests", "doc", "examples", "lib", "util" },
    .extensions = &.{ ".cpp" },
    .max_workers = 2,
    .baseline_build_cmd = "test -f build/src/foldseek",
    .build_timeout_s = 600,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
