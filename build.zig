const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const compress = b.addModule("compress", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const compress_tests = b.addTest(.{
        .root_module = compress,
    });

    const compress_tests_run = b.addRunArtifact(compress_tests);

    const test_step = b.step("test", "Unit test compression library");
    test_step.dependOn(&compress_tests_run.step);
}
