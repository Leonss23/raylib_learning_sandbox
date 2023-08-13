const Asteroid = @This();
const ray = @import("main.zig").ray;
const std = @import("std");

const MIN_ROT_SPEED = 5;
const MAX_ROT_SPEED = 240;

pub const AsteroidSize = enum(u3) {
    SMALL = 1,
    MEDIUM = 2,
    LARGE = 4,
    pub fn random() AsteroidSize {
        const value = ray.GetRandomValue(0, 2);
        switch (value) {
            0 => return .SMALL,
            1 => return .MEDIUM,
            2 => return .LARGE,
            else => unreachable,
        }
    }
};

active: bool = false,
position: ray.Vector2 = ray.Vector2{ .x = 0, .y = 0 },
velocity: ray.Vector2 = ray.Vector2{ .x = 0, .y = 0 },
size: AsteroidSize = .SMALL,
rotation: f32 = 0,
rotation_speed: f32 = 0,

pub fn init(position: ray.Vector2, velocity: ray.Vector2, size: AsteroidSize) Asteroid {
    return Asteroid{
        .active = true,
        .position = position,
        .velocity = velocity,
        .size = size,
        .rotation = @floatFromInt(ray.GetRandomValue(0, 360)),
        .rotation_speed = @floatFromInt(ray.GetRandomValue(MIN_ROT_SPEED, MAX_ROT_SPEED)),
    };
}

pub fn update(self: *Asteroid, frametime: f32) void {
    self.position = ray.Vector2Add(
        self.position,
        ray.Vector2Scale(self.velocity, frametime),
    );
    self.rotation += self.rotation_speed * frametime;
}

pub fn draw(self: *Asteroid) void {
    ray.DrawPolyLines(
        self.position,
        3,
        16.0 * @as(
            f32,
            @floatFromInt(
                @intFromEnum(self.size),
            ),
        ),
        self.rotation,
        ray.RED,
    );
}
