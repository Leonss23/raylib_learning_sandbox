const AsteroidSpawner = @This();
const Asteroid = @import("Asteroid.zig");
const AsteroidSize = Asteroid.AsteroidSize;
const std = @import("std");
const ray = @import("main.zig").ray;
const Window = @import("Window.zig");

const DEFAULT_MAX_ASTEROIDS = 64;

max_asteroids: u32,
asteroids: [DEFAULT_MAX_ASTEROIDS]Asteroid,
pub fn init() AsteroidSpawner {
    return AsteroidSpawner{
        .max_asteroids = DEFAULT_MAX_ASTEROIDS,
        .asteroids = undefined,
    };
}

pub fn spawnAll(self: *AsteroidSpawner) void {
    std.debug.print("SPAWNING ASTEROIDS\n", .{});

    for (self.asteroids, 0..) |_, idx| {
        self.asteroids[idx] = Asteroid.init(
            ray.Vector2{
                .x = @floatFromInt(ray.GetRandomValue(0, ray.GetRenderWidth())),
                .y = @floatFromInt(ray.GetRandomValue(0, ray.GetRenderHeight())),
            },
            ray.Vector2{
                .x = 0,
                .y = 0,
            },
            AsteroidSize.random(),
        );
    }
    for (self.asteroids) |asteroid| {
        std.debug.print("{any}\n", .{asteroid});
    }
}

pub fn updateAll(self: *AsteroidSpawner, frametime: f32) void {
    for (self.asteroids, 0..) |asteroid, idx| {
        if (!asteroid.active) continue;
        self.asteroids[idx].update(frametime);
    }
}

pub fn drawAll(self: *AsteroidSpawner) void {
    for (self.asteroids, 0..) |asteroid, idx| {
        if (!asteroid.active) continue;
        self.asteroids[idx].draw();
    }
}
