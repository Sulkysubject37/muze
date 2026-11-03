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
    _ = sandbox.exec(alloc, io, "ccache -z", worker_dir, 10, "/dev/null", "/dev/null") catch {};
    
    // Write a compilation script
    const script_content = 
        \\#!/bin/bash
        \\FILE=$1
        \\WDIR=$(cd "$2" && pwd)
        \\BASE_DIR=$(cd "$WDIR/../../baseline" && pwd)
        \\cd "$WDIR"
        \\JSON_LINE=$(jq -r ".[] | select(.file | endswith(\"/$FILE\")) | .directory + \"|\" + .command" build/compile_commands.json | head -n 1)
        \\if [ -z "$JSON_LINE" ]; then exit 1; fi
        \\DIR=$(echo "$JSON_LINE" | cut -d'|' -f1)
        \\CMD=$(echo "$JSON_LINE" | cut -d'|' -f2-)
        \\DIR="${DIR//$BASE_DIR/$WDIR}"
        \\CMD="${CMD//$BASE_DIR/$WDIR}"
        \\OBJ=$(echo "$CMD" | grep -o '\-o [^ ]*' | awk '{print $2}')
        \\rm -f "$DIR/$OBJ"
        \\CMD="$CMD -O3 -ffile-prefix-map=$WDIR=."
        \\cd "$DIR"
        \\eval "$CMD" || exit 1
        \\
        \\echo "$DIR/$OBJ" > "$WDIR/obj_path.txt"
    ;
    
    const script_path = try std.fmt.allocPrint(alloc, "{s}/compile.sh", .{worker_dir});
    defer alloc.free(script_path);
    std.Io.Dir.cwd().writeFile(io, .{ .sub_path = script_path, .data = script_content }) catch return error.CompileFailed;
    
    const chmod_cmd = try std.fmt.allocPrint(alloc, "chmod +x compile.sh", .{});
    defer alloc.free(chmod_cmd);
    _ = try sandbox.exec(alloc, io, chmod_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    
    const cmd = try std.fmt.allocPrint(alloc, "./compile.sh {s} .", .{file_path});
    defer alloc.free(cmd);
    
    const res = try sandbox.exec(alloc, io, cmd, worker_dir, 120, "/dev/null", "/dev/null");
    if (res.exit_code != 0) return error.CompileFailed;
    
    const obj_out_path = try std.fmt.allocPrint(alloc, "{s}/obj_path.txt", .{worker_dir});
    defer alloc.free(obj_out_path);
    
    const obj_abs_path = std.Io.Dir.cwd().readFileAlloc(io, obj_out_path, alloc, @enumFromInt(64 * 1024 * 1024)) catch return error.CompileFailed;
    const trimmed = std.mem.trim(u8, obj_abs_path, " \n\r");
    return trimmed;
}

fn linkTarget(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!bool {
    const res = try sandbox.exec(alloc, io, "cd build/src/gromacs && /bin/sh CMakeFiles/libgromacs.dir/link.txt && cd ../../lib && ln -sf libgromacs.12.0.0.dylib libgromacs.12.dylib && ln -sf libgromacs.12.dylib libgromacs.dylib", worker_dir, 120, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const res = try sandbox.exec(alloc, io, "./bin/mdlib-test --gtest_filter='-*PrEbin*:*EnergyOutput*'", try std.fmt.allocPrint(alloc, "{s}/build", .{worker_dir}), 60, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;
    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "gromacs",
    .source_root = "external/gromacs",
    .lang = .cpp,
    .source_dirs = &.{
        "src/gromacs/mdlib/update.cpp",
        "src/gromacs/mdlib/update_vv.cpp",
        "src/gromacs/mdlib/coupling.cpp",
        "src/gromacs/mdlib/lincs.cpp",
        "src/gromacs/mdlib/shake.cpp",
        "src/gromacs/mdlib/settle.cpp",
        "src/gromacs/mdlib/stat.cpp",
        "src/gromacs/mdlib/calc_verletbuf.cpp",
        "src/gromacs/pbcutil/pbc.cpp",
        "src/gromacs/topology/idef.cpp",
        "src/gromacs/topology/topology.cpp"
    },

    .skip_dirs = &.{ "tests", "testing" },
    .extensions = &.{ ".cpp", ".c" },
    .max_workers = 1,
    .baseline_build_cmd = "mkdir -p build && cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DGMX_OPENMP=OFF -DGMX_FFT_LIBRARY=fftpack -DGMX_INSTALL_NBLIB_API=OFF .. && make -j8 mdlib-test",
    .build_timeout_s = 1800,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
