const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 1. The MUZE Executable (Orchestrator)
    const muze = b.addExecutable(.{
        .name = "muze",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/mutator.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(muze);

    // 2. The Native C Sandbox (Compiled to Object/IR for TCE)
    const sandbox_c = b.addObject(.{
        .name = "sandbox_native",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });
    sandbox_c.root_module.addCSourceFile(.{ .file = b.path("src/sandbox_native.c"), .flags = &[_][]const u8{"-O2"} });

    // 3. The Safe Zig Sandbox (Tests)
    const sandbox_zig_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/sandbox_safe.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_muze = b.addRunArtifact(muze);
    const run_step = b.step("run", "Run the MUZE AST mutator pipeline");
    run_step.dependOn(&run_muze.step);

    const test_step = b.step("test", "Run the memory-safe biological tests");
    const run_tests = b.addRunArtifact(sandbox_zig_tests);
    test_step.dependOn(&run_tests.step);
}
