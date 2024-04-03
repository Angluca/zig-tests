// zig cc -c c_ptr.c
// zig run call_c.zig c_ptr.o
// zig cc call_zig.c libzig_ptr.a && ./a.out
const std = @import("std");
const expectEqual = std.testing.expect;
const assert = std.debug.assert;

pub fn main() void {
    const msg = "hello_c";
    hello_c(msg.ptr);
    hello_c(msg);
    //var msgs_for_c = [_][*:0]const u8 {"msgs_foc_c", "one"};
    //hello_all_c(msgs_for_c[0..].ptr, 2);
    var msgs = [_][]const u8{"hello", "world"}; _ = &msgs;
    var msgs_for_c: [2][*c]const u8 = undefined;
    msgs_for_c[0] = msgs[0].ptr;
    msgs_for_c[1] = msgs[1].ptr;
    hello_all_c(msgs_for_c[0..].ptr, 2);
}

//pub extern fn hello_c(str: [*c]const u8) void;
pub extern "c" fn hello_c(str: [*]const u8) void;
pub extern fn hello_all_c(msgs: [*c][*c]const u8, size: c_int) void;
//pub extern fn hello_all_c(msgs: [*c][*]const u8, size: c_int) void;
