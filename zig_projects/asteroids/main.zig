const std = @import("std");
const rl = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    const screen_width = 1920;
    const screen_height = 1080;
    const window_title = "Asteroids";
    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE);
    rl.InitWindow(screen_width, screen_height, window_title);
    defer rl.CloseWindow();

    const current_monitor = rl.GetCurrentMonitor();
    const refresh_rate = rl.GetMonitorRefreshRate(current_monitor);
    rl.SetTargetFPS(refresh_rate);

    // var aa = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // defer aa.deinit();
    // const arena = aa.allocator();
    // _ = arena;

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        defer rl.EndDrawing();
        //

        rl.ClearBackground(rl.RAYWHITE);

        rl.DrawText("fps here", 10, 10, 24, rl.BLACK);
    }
}
