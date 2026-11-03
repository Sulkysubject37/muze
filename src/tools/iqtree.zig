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
        \\
        \\# Update archive
        \\if [ -f "$DIR/libmodel.a" ]; then
        \\    ar rcs "$DIR/libmodel.a" "$DIR/$OBJ"
        \\elif [ -f "$WDIR/build/model/libmodel.a" ]; then
        \\    ar rcs "$WDIR/build/model/libmodel.a" "$DIR/$OBJ"
        \\fi
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
    const res = try sandbox.exec(alloc, io, "cd build && /bin/sh CMakeFiles/iqtree3.dir/link.txt", worker_dir, 120, "/dev/null", "/dev/null");
    return res.exit_code == 0;
}

fn runTests(alloc: std.mem.Allocator, io: std.Io, worker_dir: []const u8) anyerror!classify.Verdict {
    const run_cmd = "rm -f out_test.* && ./build/iqtree3 -s test_scripts/test_data/turtle.fa -m GTR+I+G -te test_scripts/test_data/turtle.trees -T 1 -seed 73073 --prefix out_test";
    const res = try sandbox.exec(alloc, io, run_cmd, worker_dir, 30, "/dev/null", "/dev/null");
    if (res.timed_out) return .timeout;
    if (res.exit_code != 0) return .killed;

    const verify_cmd = 
        \\awk '/Log-likelihood of the tree:/ {
        \\    lh = $5;
        \\    diff = lh - (-5369.8516);
        \\    if (diff < 0) diff = -diff;
        \\    if (diff > 0.05) exit 1;
        \\    found = 1;
        \\    exit 0;
        \\}
        \\END { if (!found) exit 1; }' out_test.iqtree
    ;
    const vres = try sandbox.exec(alloc, io, verify_cmd, worker_dir, 10, "/dev/null", "/dev/null");
    if (vres.exit_code != 0) return .killed;

    return .survived;
}

pub const adapter = ToolAdapter{
    .name = "iqtree",
    .source_root = "external/iqtree",
    .lang = .cpp,
    .source_dirs = &.{
        "model/modelmarkov.cpp",
        "model/modeldna.cpp",
        "model/rategamma.cpp",
        "model/rategammainvar.cpp",
        "model/rateinvar.cpp",
        "model/modelsubst.cpp",
    },

    .skip_dirs = &.{ "tests", "testing" },
    .extensions = &.{ ".cpp", ".c" },
    .max_workers = 1,
    .baseline_build_cmd = "mkdir -p build && cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DIQTREE_FLAGS=single -DEIGEN3_INCLUDE_DIR=/opt/homebrew/include/eigen3 -DUSE_CMAPLE=OFF -DUSE_MUTSEL=OFF -DUSE_LSD2=OFF .. && make -j8 iqtree3",
    .build_timeout_s = 1800,
    .initWorker = initWorker,
    .compileMutant = compileMutant,
    .linkTarget = linkTarget,
    .runTests = runTests,
};