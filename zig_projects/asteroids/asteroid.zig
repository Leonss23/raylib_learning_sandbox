const ray = @cImport({
    @cInclude("raylib.h");
});
const std = @import("std");

const MIN_ROT_SPEED = 5;
const MAX_ROT_SPEED = 240;

pub const Asteroid = struct {
    position: ray.Vector2,
    velocity: ray.Vector2,
    rotation: f32,
    rotation_speed: f32,

    pub fn newAsteroid(position: ray.Vector2, velocity: ray.Vector2) Asteroid {
        return Asteroid{
            .position = position,
            .velocity = velocity,
            .rotation = @floatFromInt(ray.GetRandomValue(0, 359)),
            .rotation_speed = @floatFromInt(ray.GetRandomValue(MIN_ROT_SPEED, MAX_ROT_SPEED)),
        };
    }

    pub fn render() void {}
};
