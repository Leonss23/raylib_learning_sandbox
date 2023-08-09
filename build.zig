const std = @import("std");
const print = std.debug.print;
const raylib_build = @import("raylib/src/build.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    new_run_step("basic_window", "", b, target, optimize);
    new_run_step("asteroids", "", b, target, optimize);
}

fn new_run_artifact(b: *std.Build, exe: *std.Build.Step.Compile) *std.Build.Step.Run {
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    return run_cmd;
}

fn new_run_step(comptime step_name: []const u8, description: []const u8, b: *std.Build, target: std.zig.CrossTarget, optimize: std.builtin.OptimizeMode) void {
    const step = b.step(step_name, description);

    const exe = b.addExecutable(.{
        .name = step_name,
        .root_source_file = .{ .path = "zig_projects/" ++ step_name ++ "/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);

    // add utils module
    const utils = b.addModule("utils", .{ .source_file = .{ .path = "utils.zig" } });
    exe.addModule("utils", utils);

    // link raylib
    const raylib = raylib_build.addRaylib(b, target, optimize, .{});
    const path_raylib = std.Build.LazyPath.relative("raylib/src");
    exe.linkLibrary(raylib);
    exe.addIncludePath(path_raylib);

    const run_cmd = new_run_artifact(b, exe);
    step.dependOn(&run_cmd.step);
}
