const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 1. MUZE orchestrator
    const muze = b.addExecutable(.{
        .name = "muze",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/mutator.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(muze);

    // 2. Safe Zig sandbox — executable, not just a test.
    const sandbox_exe = b.addExecutable(.{
        .name = "sandbox_safe",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/sandbox_safe.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(sandbox_exe);

    // 3. Native C sandbox — executable with its own main().
    const sandbox_c_exe = b.addExecutable(.{
        .name = "sandbox_native",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });
    sandbox_c_exe.root_module.addCSourceFile(.{
        .file = b.path("src/sandbox_native.c"),
        .flags = &[_][]const u8{ "-O2", "-std=c11", "-Wall" },
    });
    sandbox_c_exe.root_module.link_libc = true;
    b.installArtifact(sandbox_c_exe);

    // 4. Tests still available
    const sandbox_zig_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/sandbox_safe.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // 5. `zig build run` must depend on both sandboxes building
    const run_muze = b.addRunArtifact(muze);
    run_muze.step.dependOn(&sandbox_exe.step);
    run_muze.step.dependOn(&sandbox_c_exe.step);
    const run_step = b.step("run", "Run the MUZE AST mutator pipeline");
    run_step.dependOn(&run_muze.step);

    const test_step = b.step("test", "Run the memory-safe biological tests");
    test_step.dependOn(&b.addRunArtifact(sandbox_zig_tests).step);
}
