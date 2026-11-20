const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "muze",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    exe.root_module.addIncludePath(b.path("vendor/tree-sitter/lib/include"));
    exe.root_module.addIncludePath(b.path("vendor/tree-sitter/lib/src"));
    exe.root_module.addIncludePath(b.path("vendor/tree-sitter-c/src"));
    exe.root_module.addIncludePath(b.path("vendor/tree-sitter-cpp/src"));
    exe.root_module.addIncludePath(b.path("vendor/tree-sitter-rust/src"));

    exe.root_module.addCSourceFiles(.{
        .files = &.{
            "vendor/tree-sitter/lib/src/lib.c",
            "vendor/tree-sitter-c/src/parser.c",
            "vendor/tree-sitter-cpp/src/parser.c",
            "vendor/tree-sitter-cpp/src/scanner.c",
            "vendor/tree-sitter-rust/src/parser.c",
            "vendor/tree-sitter-rust/src/scanner.c",
        },
        .flags = &.{ "-std=c11", "-O2", "-fno-sanitize=undefined" },
    });

    b.installArtifact(exe);

    const run = b.addRunArtifact(exe);
    run.step.dependOn(b.getInstallStep());
    if (b.args) |args| run.addArgs(args);
    b.step("run", "Run MUZE").dependOn(&run.step);

    const exe_unit_tests = b.addTest(.{
        .root_module = exe.root_module,
    });
    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
