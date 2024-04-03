//zig build-lib zig_ptr.zig
const std = @import("std");
const print = std.debug.print;

pub export fn hello(str: [*]const u8, len:u32) void {
    std.debug.print("{s}\n", .{str[0..len]});
}

fn strlen(str: [*]const u8) u32 {
    var i: u32 = 0;
    while(str[i] > 0):(i += 1) {}
    return i;
}
pub export fn hello_all(msgs: [*c][*c]const u8, len: u32) void {
    for(0..len)|i| {
        const msg = msgs[i];
        print("{s}\n", .{msg[0..strlen(msg)]});
    }
}
