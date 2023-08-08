const std = @import("std");
const rl = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    const screen_width = 1920;
    const screen_height = 1080;
    const window_title = "Basic Window";
    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE);
    rl.InitWindow(screen_width, screen_height, window_title);
    defer rl.CloseWindow();

    const current_monitor = rl.GetCurrentMonitor();
    const refresh_rate = rl.GetMonitorRefreshRate(current_monitor);
    rl.SetTargetFPS(refresh_rate);

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        defer rl.EndDrawing();
        //

        rl.ClearBackground(rl.RAYWHITE);
        rl.DrawText(window_title, 50, 50, 48, rl.BLACK);
    }
}
