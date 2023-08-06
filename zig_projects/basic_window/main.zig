const std = @import("std");
const ray = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    ray.InitWindow(2560, 1440, "Basic Window");
    defer ray.CloseWindow();
}
