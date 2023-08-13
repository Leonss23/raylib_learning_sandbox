const std = @import("std");
pub const ray = @cImport({
    @cInclude("raylib.h");
    @cInclude("raymath.h");
});
const print = std.debug.print;
const utils = @import("utils");
const Window = @import("Window.zig");
const Asteroid = @import("Asteroid.zig");
const AsteroidSpawner = @import("AsteroidSpawner.zig");
const ui = @import("ui.zig");

var asteroid_spawner = AsteroidSpawner.init();

var frametime: f32 = undefined;
var buffer: [8]u8 = undefined;
fn getBuffer() []u8 {
    @memset(&buffer, 0);
    return &buffer;
}

pub fn main() !void {
    Window.run();
    defer Window.close();

    startup();
    while (!ray.WindowShouldClose()) {
        update();
        render();
    }
}

fn startup() void {
    asteroid_spawner.spawnAll();
}

fn update() void {
    frametime = ray.GetFrameTime();

    print("buf: {any}\n", .{buffer});
    asteroid_spawner.updateAll(frametime);
}

fn render() void {
    ray.BeginDrawing();
    defer ray.EndDrawing();
    //
    ray.ClearBackground(ray.RAYWHITE);
    ui.fpsCounter(getBuffer(), ray.GetFPS());
    asteroid_spawner.drawAll();
}
