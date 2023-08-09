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

    while (!rl.WindowShouldClose()) {
        print("buf: {any}\n", .{buffer});
        rl.BeginDrawing();
        defer rl.EndDrawing();
        rl.ClearBackground(rl.RAYWHITE);
        //

        try fpsCounter(getBuffer());

        // rl.DrawRec
    }
}

var buffer: [50]u8 = undefined;
fn getBuffer() []u8 {
    @memset(&buffer, 0);
    return &buffer;
}

fn cint_to_cstr(cint: c_int, buf: []u8) ![*c]const u8 {
    return @ptrCast(try std.fmt.bufPrint(buf, "{}", .{cint}));
}

fn fpsCounter(buf: []u8) !void {
    const fps = rl.GetFPS();

    const fps_c_str: [*c]const u8 = try cint_to_cstr(fps, buf);

    rl.DrawText(fps_c_str, 10, 10, 24, rl.BLACK);
}
