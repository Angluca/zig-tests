//zig cc -c opaque.c
//zig run opaque.zig opaque.o
const std = @import("std");

//pub const struct_Op = opaque {};
pub const struct_Op = extern struct {
    name: [*c]u8,
    names: [*c][*c]const u8,
    size: u32,
};

pub const op_t = struct_Op;
pub const op_p = ?*op_t;
pub extern fn op_new(name: [*]const u8) op_p;
//pub extern fn op_new(name: [*]const u8) ?*anyopaque;
pub extern fn op_new_all(names: [*c][*]const u8, size: u32) op_p;
//pub extern fn op_free(pp: op_p) void;
pub extern fn op_free(pp: op_p) void;
//pub extern fn hello(pp: op_p) void;
//pub extern fn hello_all(pp: op_p) void;
pub extern fn hello(pp: ?*anyopaque) void;
pub extern fn hello_all(pp: ?*anyopaque) void;

pub fn main() !void {
    {
        const pp = op_new("world");
        hello(pp);
        op_free(pp);
    }
    {
        var names = [_][*]const u8{"hello", "world"};
        _ = &names;
        const pp = op_new_all(names[0..], 2);
        //const pp = op_new_all(names[0..].ptr, 2);

        //var names = [_][]const u8{"hello", "world"};
        //var names_c: [2][*]const u8 = undefined;
        //names_c[0] = names[0].ptr;
        //names_c[1] = names[1].ptr;
        //const pp = op_new_all(names[0..].ptr, 2);
        //const pp = op_new_all(names_c[0..], 2);
        pp.?.names[0] = "test";
        hello_all(pp);
        op_free(pp);
    }
}

