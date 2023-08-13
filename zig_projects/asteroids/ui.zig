const ray = @import("main.zig").ray;
const utils = @import("utils");

pub fn fpsCounter(buf: []u8, fps: c_int) void {
    const fps_c_str: [*c]const u8 = utils.cint_to_cstr(fps, buf) catch unreachable;

    ray.DrawText(fps_c_str, 10, 10, 24, ray.BLACK);
}
