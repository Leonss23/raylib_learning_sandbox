const std = @import("std");
const raylib_build = @import("raylib/src/build.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "basic_window",
        .root_source_file = .{ .path = "zig_projects/basic_window/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const raylib = raylib_build.addRaylib(b, target, optimize, .{});

    const lazy_path_raylib = std.Build.LazyPath.relative("raylib/src");

    exe.linkLibrary(raylib);
    exe.addIncludePath(lazy_path_raylib);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the app");

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    run_step.dependOn(&run_cmd.step);
}
