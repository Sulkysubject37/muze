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
        \\SOURCE_ROOT=$(jq -r ".[] | select(.file | endswith(\"/$FILE\")) | .file" build/compile_commands.json | head -n 1 | sed "s|/$FILE$||")
        \\DIR="${DIR//$SOURCE_ROOT/$WDIR}"
        \\CMD="${CMD//$SOURCE_ROOT/$WDIR}"
        \\DIR="${DIR//$BASE_DIR/$WDIR}"
        \\CMD="${CMD//$BASE_DIR/$WDIR}"
        \\OBJ=$(echo "$CMD" | grep -o '\-o [^ ]*' | awk '{print $2}')
        \\rm -f "$DIR/$OBJ"
        \\CMD="$CMD -O3 -ffile-prefix-map=$WDIR=."
        \\cd "$DIR"
        \\eval "$CMD" || exit 1
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
    const res = try sandbox.exec(alloc, io, "cd build/src && /bin/sh CMakeFiles/raxml_module.dir/link.txt", worker_dir, 120, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const run_cmd = "rm -f out_test.raxml.* && ./build/bin/raxml-ng --evaluate --msa test_data/turtle.fa --tree test_data/turtle.trees --model GTR+G --threads 1 --seed 42 --prefix out_test --redo";
    const res = try sandbox.exec(alloc, io, run_cmd, worker_dir, 30, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const verify_cmd = 
        \\awk '/Final LogLikelihood:/ {
        \\    lh = $3;
        \\    diff = lh - (-5428.239616);
        \\    if (diff < 0) diff = -diff;
        \\    if (diff > 0.05) exit 1;
        \\    found = 1;
        \\    exit 0;
        \\}
        \\END { if (!found) exit 1; }' out_test.raxml.log
    ;
    const vres = try sandbox.exec(alloc, io, verify_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (vres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "raxml",
    .source_root = "external/raxml",
    .lang = .cpp,
    .source_dirs = &.{
        "src/Model.cpp",
        "src/Tree.cpp",
        "src/TreeInfo.cpp",
        "src/Optimizer.cpp",
        "src/PartitionInfo.cpp",
    },
    .skip_dirs = &.{ "test", "examples" },
    .extensions = &.{ ".cpp", ".c" },
    .max_workers = 2,
    .baseline_build_cmd = "mkdir -p build && cd build && cmake -DCORAX_BUILD_DIFFICULTY_PREDICTION=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. && make -j4",
    .build_timeout_s = 1800,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};
