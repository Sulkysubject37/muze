const std = @import("std");
const Lang = @import("../ir/kinds.zig").Lang;
const Adapter = @import("../runner/adapter.zig").Adapter;

fn objPathFor(alloc: std.mem.Allocator, file: []const u8) []const u8 {
    _ = file;
    return std.fmt.allocPrint(alloc, "parsed_from_db", .{}) catch unreachable;
}

pub const adapter = Adapter{
    .name = "gromacs",
    .source_root = "external/gromacs",
    .lang = .cpp,
    .extensions = &.{ ".cpp", ".c", ".h", ".hpp" },
    .source_dirs = &.{
        "src/gromacs",
    },
    .skip_dirs = &.{ "test", "tests", "external", "programs" },
    .baseline_build_cmd = "mkdir -p build && cd build && cmake .. -DGMX_BUILD_OWN_FFTW=ON -DGMX_BUILD_SHARED_EXE=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_FLAGS=\"-O3\" -DCMAKE_CXX_FLAGS=\"-O3\" && make -j8",
    .compile_db = "build/compile_commands.json",
    .compile_cmd_for = null,
    .obj_path_for = objPathFor,
    .link_cmd = "make -C build -j8",
    .test_cmd = "cd build && ctest -j8 --output-on-failure",
    .build_timeout_s = 1800,
    .test_timeout_s = 1800,
    .smoke_cmd = "./build/bin/gmx --version",
};
