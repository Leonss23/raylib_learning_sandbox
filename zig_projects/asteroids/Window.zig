const Window = @This();
const ray = @import("main.zig").ray;

const window_title = "Asteroids";
const screen_width: c_int = 1920;
const screen_height: c_int = 1080;
const config_flags = [_]c_uint{ray.FLAG_WINDOW_RESIZABLE};
const window_state_flags = [_]c_uint{ray.FLAG_WINDOW_MAXIMIZED};

pub fn run() void {
    setConfigFlags();
    ray.InitWindow(screen_width, screen_height, window_title);
    setWindowStateFlags();
    limitFPS();
}

pub fn close() void {
    ray.CloseWindow();
}

/// [PRE-INIT] Sets flags for window config
fn setConfigFlags() void {
    for (config_flags) |flag| {
        ray.SetConfigFlags(flag);
    }
}

/// [POST-INIT] Sets flags for window state
fn setWindowStateFlags() void {
    for (window_state_flags) |flag| {
        ray.SetWindowState(flag);
    }
}

/// [POST-INIT] Sets target framerate to monitor's refresh rate
fn limitFPS() void {
    const current_monitor = ray.GetCurrentMonitor();
    const refresh_rate = ray.GetMonitorRefreshRate(current_monitor);
    ray.SetTargetFPS(refresh_rate);
}
