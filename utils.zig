const std = @import("std");

pub fn cint_to_cstr(cint: c_int, buf: []u8) ![*c]const u8 {
    return @ptrCast(try std.fmt.bufPrint(buf, "{}", .{cint}));
}
