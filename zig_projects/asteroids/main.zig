pub const ray = @cImport({
    @cInclude("raylib.h");
});
const std = @import("std");
const print = std.debug.print;
const utils = @import("utils");
const Asteroid = @import("asteroid.zig").Asteroid;

const globals = struct {
    const screen_width = 1920;
    const screen_height = 1080;
    const window_title = "Asteroids";
    var buffer: [8]u8 = undefined;
};

pub fn main() !void {
    ray.SetConfigFlags(ray.FLAG_WINDOW_RESIZABLE);
    ray.InitWindow(globals.screen_width, globals.screen_height, globals.window_title);
    defer ray.CloseWindow();
    //
    startup();

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();
        //
        handleInput();
        try update();
    }
}

fn startup() void {
    limitFPS();
    initSpawn();
}

fn handleInput() void {}

fn update() !void {
    ray.ClearBackground(ray.RAYWHITE);
    try fpsCounter(getBuffer());
    print("buf: {any}\n", .{globals.buffer});
}

fn initSpawn() void {
    const ast1 = Asteroid.newAsteroid(
        ray.Vector2{ .x = 200.0, .y = 200.0 },
        ray.Vector2{ .x = 0.0, .y = 0.0 },
    );

    print("asteroid1: {any}\n", .{ast1});
}

fn limitFPS() void {
    const current_monitor = ray.GetCurrentMonitor();
    const refresh_rate = ray.GetMonitorRefreshRate(current_monitor);
    ray.SetTargetFPS(refresh_rate);
}

fn getBuffer() []u8 {
    @memset(&globals.buffer, 0);
    return &globals.buffer;
}

fn fpsCounter(buf: []u8) !void {
    const fps = ray.GetFPS();

    const fps_c_str: [*c]const u8 = try utils.cint_to_cstr(fps, buf);

    ray.DrawText(fps_c_str, 10, 10, 24, ray.BLACK);
}
