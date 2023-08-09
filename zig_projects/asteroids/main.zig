const std = @import("std");
const print = std.debug.print;
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

    var buf: [10]u8 = undefined;

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        defer rl.EndDrawing();
        //

        buf = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        rl.ClearBackground(rl.RAYWHITE);

        const fps: c_int = rl.GetFPS();

        const fps_c_str: [*c]const u8 = try cint_to_cstr(fps, &buf);

        rl.DrawText(fps_c_str, 10, 10, 24, rl.BLACK);
        print("\n", .{});
    }
}

fn cint_to_cstr(cint: c_int, buf: []u8) ![*c]const u8 {
    return @ptrCast(try std.fmt.bufPrint(buf, "{}", .{cint}));
}
