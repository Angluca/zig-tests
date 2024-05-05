const cc = @cImport({
    @cInclude("stdio.h");
});
const builtin = @import("builtin");
const std = @import("std");
const fmt = std.fmt;
const eql = mem.eql;
const mem = std.mem;
const math = std.math;
const meta = std.meta;
const ArrayList = std.ArrayList;
const testing = std.testing;

const Allocator = std.mem.allocator;
const bufPrint = fmt.bufPrint;
const sentinel = std.meta.sentinel;
const assert = std.debug.assert;
const print = std.debug.print;

const parseInt = fmt.parseInt;
const parseFloat = fmt.parseFloat;
const parseUnsigned = fmt.parseUnsigned;
const parseIntSizeSuffix = fmt.parseIntSizeSuffix;

const expect = std.testing.expect;
const expectError = std.testing.expectError;
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;
const expectEqualStrings = std.testing.expectEqualStrings;

//@divExact这些编译期函数结果只有整数!!!
//判断加|xx|后判断?type就跟c语言一样,非null为true: while/if/..(?i32)|val|
//pub fn print(self: Insect) void {
    //switch (self) {
        //inline else => |case| return case.print(),
    //}
//}
/// test generate documentation
pub fn main() void {
    //@compileLog("echo everything type", main);
    //std.debug.print("test:({any}), world:({?})!!!!", .{@typeInfo(u8), @TypeOf("world")});

//    const a: [5]u8 = "array".*;
//    const b: *const [16]u8 = "pointer to array";
//    const c: []const u8 = "slice";
//    const d: [:0]const u8 = "slice with sentinel";
//    const e: [*:0]const u8 = "many-item pointer with sentinel";
//    const f: [*]const u8 = "many-item pointer";
    const @"!!!666666": i32 = 666; _ = @"!!!666666";
    print("{s}",.{"打中文咯"});
    //const arr = [2][3]u8 {.{2,2,2}, .{2,2,2}};
    const arr = [_][3]u8 {.{2,2,2}, .{2,2,2}};
    print("{any}\n", .{@TypeOf(arr)});
    print("{any}\n", .{@TypeOf(arr[0..])});
    print("{any}\n", .{@TypeOf(arr[0][0..])});
    //const arr2 =  [2][]const u8{"ssss","ffff"};
    //const arr3 =  [2][*]const u8{"ssss","ffff"};
    const arr2 =  [_][]const u8{"ssss","ffff"};
    const arr3 =  [_][*]const u8{"ssss","ffff"};
    print("{any}\n", .{@TypeOf(arr2[0..])});
    print("{any}\n", .{@TypeOf(&arr2[0])});
    print("{any}\n", .{@TypeOf(arr3[0..])});
    print("{any}\n", .{@TypeOf(&arr3[0])});

    //const n = 6;
    //const xx = blk: {
        //const xxx = if(n > 0) n else blk2: {
            //break :blk2 -1;
        //};
        //if (xxx>0) { break :blk xxx;}
        //else break :blk n;
    //};
    //_ = xx;

}

test "-- Zig testing --" {
    try expect(true);
    const big_address: u32 = 0xFF80_00ff;
    _ = big_address;
    _ = 1_000_000;
    _ = 0b1100_0011;
    _ = 0o7_6_5;
    //const constant: i32 = 5;
    //var variable: u32 = 5000;
    //const inferred_constant = @as(i32, constant);
    //var inferred_variable = @as(u32, variable);
    //const a: i32 = undefined;
    //var b: u32 = undefined;
    const cz: [3]u8 = .{'h', 'e', 'l'};
    const ccz= [_]u8{'l', 'o', '!'};
    const cccz = cz ++ ccz;
    try expect(cccz.len == 6);
}
test "-- if statement --" {
    const xx = if(true) 2 else 0;
    _ = xx;
    const a = true;
    var x: u16 = 0;
    if(a) {x+=1;}
    else {x+=2;}

    x += if(a) 1 else 2;
    try expect(x == 2);
}
test "-- while with break, continue and expression--" {
    const xx = while(true) break 2 else 0;
    _ = xx;
    const xxx: u8 = while(true) { break 3; } else 0;
    _ = xxx;
    var i: u8 = 2;
    while(i < 100) {
        i *= 2;
    }
    try expect(i==128);

    var sum: u8 = 0; i = 1;
    while(i <= 10):(i += 1) {
        sum += i;
    }
    print("{d}; ", .{sum});
    try expect(sum == 55);

    sum = 0; i = 0;
    while(i <= 3) : (i += 1) {
        if(i == 2) continue;
        sum += i;
    }
    //assert(sum == 4);
    try expect(sum == 4);

    sum = 0; i = 0;
    while (i <= 3):(i += 1) {
        if (i == 2) break;
        sum += i;
    }
    try expect(sum == 1);
}
test "-- for loops --" {
    var str = [3]u8{'a', 'b', 'c'};
    const str2 = [_]u8{'d', 'e', 'f'};
    const xx: u8 = for(str)|_| break 2 else 0;
    _ = xx;
    const xxx: u8 = for(str)|_| {break 2;} else 0;
    _ = xxx;
    for(str, str2)|s1, s2| {
        try expect((s1+3) == s2);
    }
    for(&str, 0..)|*chr, idx| {
        if(idx == 2) chr.* = 'g';
        _ = &chr;
        _ = &idx;
    }
    for (str, 0..)|_, idx| {
        _ = idx;
    }
    for(str) |_| {}
}
fn addFive(x: u32) u32 { return x + 5; }
fn fibonacci(n: u16) u16 {
    if(n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}
test "-- function recursion--" {
    const y = addFive(0);
    try expect(@TypeOf(y) == u32);
    try expect(y == 5);

    const x = fibonacci(10);
    try expect(x == 55);
}
test "-- defer --" {
    var x: i16 = 5;
    {
        defer x += 2; // last run
        defer x *= 2;
        try expect(x == 5);
    }
    try expect(x == 12);
    var y: f32 = 5;
    {
        defer {
            y /= 2;
            y += 2; // last run
        }
        try expect(y == 5);
    }
    try expect(y == 4.5);
}
fn failingFunction() error{Oops}!void {
    return error.Oops;
}
test "-- error union and returning a error --" {
    const FileOpenError = error{
        AccessDenied, OutOfMemory, FileNotFound,
    };
    const AllocationError = error{OutOfMemory};
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);

    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;
    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);

    failingFunction() catch |err2| {
        try expect(err2 == error.Oops);
    };
    failingFunction() catch |err2| switch(err2) {
        error.Oops => {},
        else => unreachable,
    };
}
fn failFn() error{Oops}!i32 {
    try failingFunction(); // try is (func() catch |err| return err);
    return 12;
}
test "-- try --" {
    const v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };
    try expect(v == 12); // is never reached
    print("eeeeeeeeeeeer!-------", .{});
}
var problems: u32 = 98;
fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}
test "-- errdefer --" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}
fn createFile() !void {
    return error.AccessDenied;
}
test "-- inferred error set --" {
    const x: error{AccessDenied}!void = createFile();
    _ = x catch {};
    const A = error{NotFound, NotReady};
    const B = error{OutOfMemory, PathNotFound};
    const C = A || B; _ = C;
}
test "-- switch statement and expression --" {
    var x: i8 = 10;
    switch(x) {
        -1...1 => {
            x = -x;
        },
        10, 100 => {
            x = @divExact(x, 10);
        },
        else => {},
    }
    try expect(x == 1);
    x = 66;
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    try expect(x == 66);
}
fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}
test "-- out of bounds and unreachable --" {
    //@setRuntimeSafety(false);
    //const a = [3]u8{1, 2, 3};
    //const idx: u8 = 5;
    //const b = a[idx];
    //_ = b;
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}
fn increment(n: *u8) void {
    n.* += 1;
}
fn echos(msgs:[*][]const u8) void {
    _ = &msgs;
}
test "-- pointers --" {
    {
        var x: i32 = 1234;
        const y: *[1]i32 = &x;
        const y2: *[1:0]i32 = &x; _ = &y2;
        var z: [*]i32 = y;
        const a: [*:0]i32 = @ptrCast(y);
        const a2: [*:0]i32 = @ptrCast(&x); _ = &a2;
        const b: []i32 = @as(*[1]i32, &a[0]);
        const c: []i32 = mem.span(@as([*:0]i32, @ptrCast(z)));
        const c2: []i32 = mem.span(a); _ = &c2;
        const c3: []i32 = a[0..1]; _ = &c3;
        const c4: []const i32 = (&[_]i32{1,2})[0..1:2]; _ = &c4;
        z = @ptrCast(b);
        z = c.ptr;
    } {
        var x: u8 = 1;
        increment(&x);
        try expect(x == 2);
        const z: u16 = 0x222;
        const y: *u8 = @as(*u8, @ptrFromInt(z));
        _ = y;
        var a: u8 = 1;
        const b = &a;
        b.* += 1;
        print("sizeof usize isize *u8 = {}; ", .{@sizeOf(*u8)});
        try expect(@sizeOf(usize) == @sizeOf(@TypeOf(&a)));
        try expect(@sizeOf(isize) == @sizeOf(*u8));
    } {
        const msg = "hellow" ++ " msg!";
        try expectEqual(*const[11:0]u8, @TypeOf(msg));
        try expectEqual([*:0]const u8, @TypeOf(msg.ptr));

        var msgs = [2][]const u8{"hello","world"};
        echos(&msgs);
        echos(msgs[0..][0..]);
        echos(msgs[0..].ptr);

        try expectEqual([2][]const u8, @TypeOf(msgs));
        try expectEqual([]const u8, @TypeOf(msgs[0]));
        try expectEqual(*[2][]const u8, @TypeOf(msgs[0..]));

        try expectEqual(u8, @TypeOf(msgs[0][0]));
        try expectEqual([]const u8, @TypeOf(msgs[0][0..]));
        try expectEqual([]const u8, @TypeOf(msgs[0..][0]));
        try expectEqual(*[2][]const u8, @TypeOf(msgs[0..][0..]));

        try expectEqual([*]const u8, @TypeOf(msgs[0].ptr));
        try expectEqual([*][]const u8, @TypeOf(msgs[0..].ptr));

        try expectEqual([*]const u8, @TypeOf(msgs[0][0..].ptr));
        try expectEqual([*]const u8, @TypeOf(msgs[0..][0].ptr));
        try expectEqual([*][]const u8, @TypeOf(msgs[0..].ptr));
        try expectEqual([*][]const u8, @TypeOf(msgs[0..][0..].ptr));
        //print("=={any}==\n", .{@TypeOf(msgs[0..][0])});
    } {
        // function pointer
        //const EchoFn = @TypeOf(&echos);
        const EchoFn = *const fn(msgs:[*][]const u8) void;
        const echofn: EchoFn = echos;
        //const echofn = echos;
        _ = &EchoFn; _ = &echofn;
        try expect(@TypeOf(echofn) == EchoFn);
    } {
        // allow ptr address is 0
        const zero: usize = 0;
        const ptr: *allowzero i32 = @ptrFromInt(zero);
        try expect(@intFromPtr(ptr) == 0);
    } {
        comptime {
            const ptr: *i32 = @ptrFromInt(0xdeadbee0);
            const addr = @intFromPtr(ptr);
            try expect(@TypeOf(addr) == usize);
            try expect(addr == 0xdeadbee0);
        }
    } {
        // comptime can use ptr
        comptime {
            var x: i32 = 1;
            const ptr = &x;
            ptr.* += 1;
            x += 1;
            try expect(ptr.* == 3);
        }
    }
}
test "-- pointer casting --" {
    const bytes2 align(@alignOf(u32)) = [_]u8{ 0x34, 0x34, 0x12, 0x12 };
    const u32_ptr2: *const u32 = @ptrCast(&bytes2);
    try expect(u32_ptr2.* == 0x12123434);

    const bytes = [_]u8{ 0x12, 0x34, 0x56, 0x78 };
    const u32_ptr: *const u32 = &@bitCast(bytes);
    try expect(u32_ptr.* == 0x78563412);

    const u32_value = std.mem.bytesAsSlice(u32, bytes[0..])[0];
    try expect(u32_value == 0x78563412);

    try expect(@as(u32, @bitCast(bytes)) == 0x78563412);

    try expect(@typeInfo(@TypeOf(u32_ptr)).Pointer.child == u32);
}
test "-- pointer alignment safety --" {
    var array align(4) = [_]u32{ 0x11111111, 0x11111111 };
    const bytes = mem.sliceAsBytes(array[0..]);
    const slice4 = bytes[1..5];
    const int_slice = mem.bytesAsSlice(u32, slice4[0..]);
    try expect(int_slice[0] == 0x11111111);
}
test "-- allowzero pointer --" {
    var zero: usize = 0; _ = &zero;
    const ptr: *allowzero i32 = @ptrFromInt(zero);
    try expect(@intFromPtr(ptr) == 0);
}
test "-- align alignOf alignment--" {
    var x: i32 = 1234;
    const alignOf_i32 = @alignOf(@TypeOf(x)); // @alignOf(i32)
    try expect(alignOf_i32 == 4); // sizeof i32
    try expect(@TypeOf(&x) == *i32);
    try expect(*i32 == *align(4) i32);

    if(builtin.target.cpu.arch == .x86_64) {
        try expect(@typeInfo(*i32).Pointer.alignment == 4);
    }

    var foo: u8 align(4) = 100;
    var foo_ptr: *align(4) u8 = &foo; _ = &foo_ptr;
    try expect(@TypeOf(&foo) == *align(4) u8);
    try expect(@TypeOf(foo_ptr) == @TypeOf(&foo));
    try expect(@typeInfo(@TypeOf(&foo)).Pointer.alignment == 4);
    const as_ptr_to_array: *align(4) [1]u8 = &foo;
    const as_slice: []align(4) u8 = as_ptr_to_array;
    const as_unaligned_slice: []u8 = as_slice;
    try expect(as_unaligned_slice[0] == 100);

    try expect(derp() == 1234);
    try expect(@typeInfo(*u32).Pointer.child == u32);
    noop1();
    try expect(@TypeOf(noop1) == fn () void);
    try expect(@TypeOf(&noop1) == *align(1) const fn () void);
    noop4();
    try expect(@TypeOf(noop4) == fn () void);
    try expect(@TypeOf(&noop4) == *align(4) const fn () void);
}
fn derp() align(@sizeOf(usize)*2) i32 { return 1234; }
fn noop1() align(1) void {}
fn noop4() align(4) void {}
fn total(vals: []const u8) usize {
    var sum: usize = 0;
    for(vals) |v| sum += v;
    return sum;
}
test "-- slices --" {
    const array = [_]u8{1, 2, 3, 4, 5};
    const slice = array[0..3];
    const slice2 = array[0..];
    const slice3 = array[0..4:5];
    try expect(total(slice) == 6);
    try expect(@TypeOf(slice) == *const [3]u8);
    try expect(@TypeOf(slice2) == *const [5]u8);
    try expect(@TypeOf(slice3) == *const [4:5]u8);
}
const Direction = enum {north, south, east, west};
const Value = enum(u2) {zero, one, two};
const Value2 = enum(u32) {
    handred = 100,
    thousand = 1000,
    million = 1000000,
    next,
};
const Suit = enum {
    clubs, spades, diamonds, hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};
const Mode = enum {
    var count: u32 = 0;
    on,
    off,
};
test "-- enums @tagName --" {
    try expect(eql(u8, @tagName(Value.zero), "zero"));
    try expect(eql(u8, @tagName(Value2.handred), "handred"));
    try expect(eql(u8, @tagName(Suit.hearts), "hearts"));
    try expect(eql(u8, @tagName(Mode.off), "off"));

    try expect(@intFromEnum(Value.zero) == 0);
    try expect(@intFromEnum(Value.one) == 1);
    try expect(@intFromEnum(Value.two) == 2);

    try expect(@intFromEnum(Value2.handred) == 100);
    try expect(@intFromEnum(Value2.million) == 1000000);
    try expect(@intFromEnum(Value2.next) == 1000001);

    try expect(Suit.spades.isClubs() == Suit.isClubs(.spades));
    Mode.count += 1;
    try expect(Mode.count == 1);
}
const Vec3 = struct {x: f32, y: f32, z: f32};
const Vec2 = struct {x: f32 = 0, y: f32 = 0};
test "-- struct usage --" {
    const my_vector = Vec3 {
        .x = 0, .y = 100, .z = 50,
    };
    _ = my_vector;
    const my_vector2: Vec2 = .{
        .x = 25,
    };
    _ = my_vector2;
}
const Stuff = struct {
    x: i32, y: i32,
    fn swap(self: *Stuff) void {
        const tmp = self.x;
        self.*.x = self.y;
        self.y = tmp; // can auto derefer so not need use .*
    }
};
test "-- automatic dereference (.*) --" {
    var thing = Stuff{.x = 10, .y = 20};
    thing.swap();
    try expect(thing.x == 20);
    try expect(thing.y == 10);
}
const Result = union {
    i: i32,
    f: f32,
    b: bool,
};
const Tag = enum {a, b, c};
const Tagged = union(Tag) {a: u8, b: f32, c: bool};
const Tagged2 = union(enum) {a: u8, b: f32, c: bool, none};
test "-- switch on tagged union -- " {
    const result = Result{.i = 2222};
    _ = result.i;
    //var val = Tagged{.a = 5};
    var val = Tagged{.b = 1.5};
    //var val = Tagged2{.b = 1.5};
    switch(val) {
        .a => |*byte| { print("byte:{}, ",.{byte.*}); byte.* += 1; },
        .b => |*float| float.* *= 2,
        .c => |*b| b.* = !b.*,
        //else => unreachable,
    }
    //try expect(val.a == 6);
    try expect(val.b == 3);
}
test "-- int widening --" {
    const x: u64 = 255;
    const xx: u8 = @intCast(x);
    try expect(xx == 255);
    var y = @as(u8, x);
    try expect(@TypeOf(y) == u8);
    y +%= 1; // 255 +% 1 = 0
    try expect(y == 0);
    y -%= 1; // 0 -% 1 = 255
    try expect(y == 255);
    y *%= 2; // 255 +% 255 = 254
    try expect(y == 254);
    y +|= 2; // 254 +| n = 255
    try expect(y == 255); y = 0;
    y -|= 1; // 0 -| n = 0
    try expect(y == 0); y = 255;
    y *|= 2; // 255 *| n = 255
    try expect(y == 255); y = 1;
    y <<|= 100; // 255 <<| n = 255
    try expect(y == 255);

    const z: u64 = 0xffffff10;
    const zz: u8 = @truncate(z);
    try expect(zz == 16);
}
test "-- float widening --" {
    const a: i32 = 0;
    const b: f32 = a;
    const c: f128 = b;
    try expect(c == @as(f128, a));
    const fmax: f64 = math.floatMax(f64);
    @setFloatMode(.optimized);
    const finf: f32 = @floatCast(fmax);
    try expect(finf == math.inf(f32));
    //@compileLog(ff);
    //const floating_point: f64 = 123.0E+77;
    //const another_float: f64 = 123.0;
    //const yet_another: f64 = 123.0e+77;

    //const hex_floating_point: f64 = 0x103.70p-5;
    //const another_hex_float: f64 = 0x103.70;
    //const yet_another_hex_float: f64 = 0x103.70P-5;
    //const lightspeed: f64 = 299_792_458.000_000;
    //const nanosecond: f64 = 0.000_000_001;
    //const more_hex: f64 = 0x1234_5678.9ABC_CDEFp-10;

    const d = @as(f32, @floatCast(c));
    //const d = @as(f32, c);
    //const e = @as(i32, @intFromFloat(d));
    const e = @as(i32, d);
    const f = @as(u16, c);
    const g = @as(i8,f);
    //const g = @as(i8, @intCast(f));
    _ = g;
    try expect(e == a);
}
test "-- labelled blocks --" {
    const count = blk: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while(i < 10):(i += 1) sum += i;
        break :blk sum;
    };
    try expect(count == 45);
    try expect(@TypeOf(count) == u32);
}
test "-- nested continue --" {
    var count: usize = 0;
    outer: for ([_]i32{1,2,3,4,5,6,7,8})|_| {
    //for ([_]i32{1,2,3,4,5,6,7,8})|_| {
        for([_]i32{1,2,3,4,5})|_| {
            count += 1;
            continue :outer;
            //break;
        }
    }
    try expect(count == 8);
}
fn rangeHasNumber(begin: usize, end: usize, number: usize) bool{
    var i = begin;
    return while(i < end):(i += 1) {
        if(i == number) {
            break true;
        }
    } else false;
}
test "-- while loop expression & @call fn --" {
    try expect(rangeHasNumber(0, 10, 3));
    try expect(@call(.auto, rangeHasNumber, .{0, 10, 3}));
}
test "-- optional and orelse -- " {
    var found_idx: ?usize = null;
    const data = [_]i32{1,2,3,4};
    for(data, 0..)|v, i| {
        if(v == 5) found_idx = i;
    }
    try expect(found_idx == null);

    const a: ?f32 = null;
    const b = a orelse 0;
    try expect(b == 0);
    //try expect(@TypeOf(b) == f32);

    const e: ?u2 = 3;
    const c = e orelse unreachable;
    const d = e.?;
    try expect(d == c);
    try expect(d == 3);
    try expect(@TypeOf(d) == u2);
}
test "-- if optional payload capture --" {
    const a: ?i32 = 5;
    if(a)|aa| {
        const v1 = a.?;
        const v2 = aa;
        _ = v1;
        _ = v2;
    }
    var b: ?i32 = 5;
    if(b) |*value| {
        value.* += 1;
    }
    try expect(b.? == 6);
}
var number_left: u32 = 4;
fn eventuallyNullSequence() ?u32 {
    if(number_left == 0) return null;
    number_left -= 1;
    return number_left;
}
test "-- while null capture --" {
    var sum: u32 = 0;
    while(eventuallyNullSequence())|val| {
        sum += val;
    }
    try expect(sum == 6); // 3 + 2 + 1
}
test "-- comptime blocks --" {
    const x = comptime fibonacci(10);
    const y = comptime blk: {
        break :blk fibonacci(10);
    };
    print("x={},y={}; ", .{x, y});
    try expect(x == y);
}
test "-- branching on types --" {
    const a = 5;
    const b: if(a < 10) u8 else f32 = 5;
    try expect(b == 5);
}
fn MatrixType(
    comptime T: type,
    comptime w: comptime_int,
    comptime h: comptime_int,) type {
    return [h][w]T;
}
test "-- returning a type --" {
    try expect(MatrixType(f32, 3, 4) == [4][3]f32);
}
fn addSmallInts(comptime T: type, a: T, b: T) T {
    return switch(@typeInfo(T)) {
        .ComptimeInt => a + b,
        .Int => |info|
            if(info.bits <= 16) a + b + 2
            else @compileError("ints too large"),
        else => @compileError("only ints accepted"),
    };
}
test "-- typeinfo switch --" {
    const x = addSmallInts(comptime_int, 20, 300);
    try expect(@TypeOf(x) == comptime_int);
    try expect(x == 320);
    const y = addSmallInts(u16, 20, 30);
    try expect(@TypeOf(y) == u16);
    try expect(y == 52);
}
fn getBiggerInt(comptime T: type) type {
    return @Type(.{
        .Int = .{
            .bits = @typeInfo(T).Int.bits + 1,
            //.signedness = @typeInfo(T).Int.signedness,
            .signedness = @typeInfo(u8).Int.signedness,
        },
    });
}
test "-- @Type --" {
    try expect(getBiggerInt(u8) == u9);
    //try expect(getBiggerInt(i31) == i32);
    try expect(getBiggerInt(i31) == u32);
}
fn Vec(comptime n: comptime_int, comptime T: type,) type {
    return struct {
        data: [n]T,
        const Self = @This();
        fn abs(self: Self) Self {
            var tmp = Self{.data = undefined,};
            for(self.data, 0..)|elem, i| {
                //tmp.data[i] = if(elem < 0) -elem else elem;
                tmp.data[i] = @abs(elem);
            }
            return tmp;
        }
        fn nothing(self: Self) void {
            _ = self;
            return;
        }
        fn init(data: [n]T) Self {
            return Self{.data = data,};
        }
    };
}
test "-- generic vector --" {
    const x = Vec(3, f32).init([_]f32{10, -10, -5});
    const y = x.abs();
    y.nothing();
    try expect(eql(f32, &y.data, &[_]f32{10, 10, 5}));
}
fn plusOne(x: anytype) @TypeOf(x) {
    return x + 1;
}
test "-- inferred function parameter" {
    try expect(plusOne(@as(u32, 1)) == 2);
}
test "++" {
    const x: [4]u8 = undefined;
    const y = x[0..];
    const a: [6]u8 = undefined;
    const b = a[0..];
    const yb = y ++ b;
    try expect(yb.len == 10);
}
test "**" {
    const x = [_]u8{0xCC, 0xFF};
    const y = x ** 3;
    try expect(eql(u8, &y, &[_]u8{0xCC,0xFF,0xCC,0xFF,0xCC,0xFF}));
}
test "-- (option is ?type == null or type) optional-if --" {
    var maybe_num: ?usize = 10; // (?usize) is (null or usize)
    if(maybe_num)|n| {
        try expect(@TypeOf(n) == usize);
        try expect(n == 10);
    } else unreachable; // null is false

    if(maybe_num)|*n| {
        n.* += 1;
        try expect(@TypeOf(n) == *usize);
        try expect(n.* == 11);
    }
}
test "-- err!type: error union if --" {
    const ent_num: error{UnknownEntity}!u32 = 5;
    if(ent_num)|entity| {
        try expect(@TypeOf(entity) == u32);
        try expect(entity == 5);
    } else |err| { // goto else when ent_num is error type
        _ = err catch {};
        unreachable;
    }
}
test "-- while optional --" {
    var i: ?u32 = 10;
    while(i)|num|:(i.? -= 1) {
        try expect(@TypeOf(num) == u32);
        if(num == 0) {
            i = null;
            break;
        }
    }
    try expect(i == null);
}
var number_left2: u32 = undefined;
fn eventuallyNullSequence2() !u32 { // !type is std_errors!type
    return if(number_left2 == 0) error.ReachedZero
        else blk: {
            number_left2 -= 1;
            break :blk number_left2;
        };
}
test "-- while error union capture --" {
    var sum: u32 = 0;
    number_left2 = 3;
    while(eventuallyNullSequence2())|val| {
        sum += val;
    } else |err| { // goto else when while(error)
        try expect(err == error.ReachedZero);
    }
    try expect(sum == 3);
}
const Info = union(enum) {
    a: u32,
    b: []const u8,
    c, // void
    d: u32,
};
test "-- switch capture --" {
    //const b = Info {.a = 10};
    const b = Info {.c = {}};
    const x = switch(b) {
        .b => |str| blk: {
            try expect(@TypeOf(str) == []const u8);
            break :blk 1;
        },
        .c => 2,
        .a, .d => |num| blk: {
            try expect(@TypeOf(num) == u32);
            break :blk num * 2;
        },
    };
    //try expect(x == 20);
    try expect(x == 2);
}
test "-- for with pointer capture --" {
    var data = [_]u8{1,2,3};
    for(&data)|*byte| byte.* += 1;
    try expect(eql(u8, &data, &[_]u8{2,3,4}));
}
inline fn inline_test() u32 { return 66; }
test "-- inline function for while --" {
    const types = [_]type{i8,u16,f32,bool};
    var sum: usize = 0;
    inline for(types)|T| sum += @sizeOf(T);
    try expect(sum == 8);

    try expect(inline_test() == 66);
}
//const Window = opaque {
    //fn show(self: *Window) void {
        //show_window(self);
    //}
//};
//extern fn show_window(*Window) callconv(.C) void;
//test "-- opaque --" {
    //var main_window: *Window = undefined;
    //main_window.show();
//}
test "-- anonymous struct literal --" {
    const Point = struct {x:i32, y:i32};
    const pt: Point = .{
        .x = 13,
        .y = 66,
    };
    try expect(pt.x == 13);
    try expect(pt.y == 66);
}
test "-- tuple --" {
    const tpl = .{
        1234,
        @as(f32, 12.24),
        true,
        "hi",
    } ++ .{false} ** 2;
    try expect(tpl[0] == 1234);
    try expect(tpl[5] == false);
    inline for(tpl, 0..)|v, i|{
        if(i != 2) continue;
        try expect(v);
    }
    try expect(tpl.len == 6);
    try expect(tpl.@"0" == 1234);
    try expect(tpl.@"3"[0] == 'h');
    const str = 'd';
    try expect(tpl[str-'a'][0] == 'h');
    try expect(tpl[str-'b'] == true);
    try expect(tpl[str-'c'] == 12.24);
    try expect(tpl[str-'d'] == 1234);
    const sf = "1";
    try expect(@field(tpl, sf) == 12.24);
    try expect(@field(tpl, "2") == true);

    const Tuple = struct{u8, u16, i32};
    const tuple: Tuple = .{22, 2222, 222222};
    const a = tuple;
    //_ = a;
    const Tuple2 = struct{u8, u8, u8};
    const tuple2: Tuple2 = .{2, 22, 222};
    const array: [3]u8 = tuple2;
    //_ = array;
    try expect(array[1] == a.@"0");
}
test "-- sentinel termination slicing --" {
    const terminated = [3:0]u8{3, 2, 1};
    try expect(terminated.len == 3);
    try expect(@as(*const [4]u8, @ptrCast(&terminated))[3] == 0);

    var x = [1:0]u8{255} ** 3;
    const y = x[0..3: 0];
    try expect(y[3] == 0);
}
test "-- cstring literal and coercion --" {
    try expect(@TypeOf("hello") == *const [5:0]u8);
    //const c_str: [:0]const u8 = "hello";
    //_ = c_str.len;
    const c_str: [*:0]const u8 = "hello"; // cstring can't get len
    var array: [5]u8 = undefined;
    var i: usize = 0;
    while(c_str[i] != 0):(i += 1) {
        array[i] = c_str[i];
    }

    const a: [*:0]u8 = undefined;
    const b: [*]u8 = a;
    _ = b;

    const c: [5:0]u8 = undefined;
    const d: [5]u8 = c;
    _ = d;

    const e: [:0]f32 = undefined;
    const f: []f32 = e;
    _ = f;
}
test "-- @vector --" {
    const Vec4 = @Vector(4, i32);
    // splat
    const c: Vec4 = @splat(4);
    try expect(meta.eql(c, @Vector(4, f32){4, 4, 4, 4}));
    // add
    const x: Vec4 = .{1,-40,20,-1};
    const y: @Vector(4, i32) = .{2, 10, 0, 7};
    const z = x + y;
    try expect(meta.eql(z, @Vector(4, i32){3,-30,20,6}));
    try expect(x[1] == -40);
    // scalar
    const a: @Vector(3, f32) = .{12.5, -37.5, 2.5};
    const b = a * @as(@Vector(3, f32), @splat(2));
    try expect(meta.eql(b, @Vector(3, f32){25, -75, 5}));
    // looping
    const sum = ret: {
        var tmp: u10 = 0;
        var i: u8 = 0;
        while(i < 4):(i += 1) tmp += @as(u10, @intCast(y[i]));
        break :ret tmp;
    };
    try expect(sum == 19);
    // array to Vector
    var arr: [4]f32 = [_]f32 {1.1, 2.2, 3.3, 4.4};
    const vec1: @Vector(4, f32) = arr;
    const vec2: @Vector(2, f32) = arr[1..3].*;
    _ = vec1; _ = vec2;
    // reduce .And .Or .Xor .Min .Max .Add .Mul ..
    const V = @Vector(4, i32);
    const value = V{1,-1,1,-1};
    const result = value > @as(V, @splat(0));
    // result is { true, false, true, false };
    const is_all_true = @reduce(.And, result);
    try expect(is_all_true == false);
    const is_min = @reduce(.Min, V{10, 2, 6, 4});
    try expect(is_min == 2);
    const result_add = @reduce(.Add, V{10, 2, 6, 4});
    try expect(result_add == 22);
    const result_mul = @reduce(.Mul, V{2, 2, 2, 2});
    try expect(result_mul == 16);

    // shuffle
    const aa = @Vector(7, u8){ 'o', 'l', 'h', 'e', 'r', 'z', 'w' };
    const bb = @Vector(4, u8){ 'w', 'd', '!', 'x' };
    const mask1 = @Vector(5, i32){2,3,1,1,0};
    const res1: @Vector(5, u8) = @shuffle(u8, aa, undefined, mask1);
    _ = res1; // res1 is hello
    const mask2 = @Vector(6, i32){-1,0,4,1,-2,-3}; // n is a, -n is b
    const res2: @Vector(6, u8) = @shuffle(u8, aa, bb, mask2);
    _ = res2; // res2 is world!
    // select
    const aaa = Vec4{1,2,3,4};
    const bbb = Vec4{5,6,7,8};
    const pred = @Vector(4, bool){true, false, false, true};
    const ccc = @select(i32, pred, aaa, bbb); // true a, false b
    _ = &ccc; // ccc is {1,6,7,4}
}
fn testAllocator(a: mem.Allocator) void {
    // base allocator is std.mem.allocator
    // use std.testing.allocator test leak
    _ = a;
}
test "-- allocation --" {
    //const allocator = std.heap.page_allocator;
    const allocator = testing.allocator;
    testAllocator(allocator);
    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);
    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);
}
test "-- fixed buffer allocator --"{
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    defer fba.reset();
    const allocator = fba.allocator();
    testAllocator(allocator);
    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);
    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);

    const json = try std.json.stringifyAlloc(allocator, .{
        .this_is = "an anonymous struct",
        .above = true,
        .last_param = "are options",
    }, .{.whitespace = .indent_2});
    defer allocator.free(json);
    print("{s} ", .{json});
}
test "-- arena allocator --" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // this will free anything created from this arena
    defer arena.deinit();
    const allocator = arena.allocator();
    testAllocator(allocator);
    _ = try allocator.alloc(u8, 1);
    _ = try allocator.alloc(u8, 10);
    _ = try allocator.alloc(u8, 100);
}
test "-- allocator create/destroy" {
    const pbyte = try std.heap.page_allocator.create(u8);
    testAllocator(std.heap.page_allocator);
    defer std.heap.page_allocator.destroy(pbyte);
    pbyte.* = 128;
}
test "-- GPA --" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    testAllocator(allocator);
    defer {
        const deinit_status = gpa.deinit();
        if(deinit_status == .leak)
            expect(false) catch @panic("TEST FAILED");
    }
    const bytes = try allocator.alloc(u8, 100);
    defer allocator.free(bytes);
}
test "-- arraylist --" {
    testAllocator(testing.allocator);
    var list = ArrayList(u8).init(testing.allocator);
    defer list.deinit();
    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');
    try list.appendSlice(" world!");
    try expect(eql(u8, list.items, "Hello world!"));
}
test "-- createFile, write, seekTo, read --" {
    //var file = try std.fs.cwd().openFile("test_file.txt", .{});
    const file = try std.fs.cwd().createFile(
        "test_file.txt",
        .{.read = true},);
    defer file.close();
    const bytes_written = try file.writeAll("Hello file");
    _ = bytes_written;
    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);
    try expect(eql(u8, buffer[0..bytes_read], "Hello file"));
}
test "-- file stat --" {
    const file = try std.fs.cwd().createFile("test_file2.txt", .{.read=true});
    defer file.close();
    const stat = try file.stat();
    try expect(stat.size == 0);
    try expect(stat.kind == .file);
    try expect(stat.ctime <= std.time.nanoTimestamp());
    try expect(stat.mtime <= std.time.nanoTimestamp());
    try expect(stat.atime <= std.time.nanoTimestamp());
}
test "-- make dir --" {
    try std.fs.cwd().makeDir("test-tmp");
    var iter_dir = try std.fs.cwd().openDir("test-tmp",.{});
    defer {
        iter_dir.close();
        std.fs.cwd().deleteTree("test-tmp") catch unreachable;
    }
    _ = try iter_dir.createFile("x.txt", .{});
    _ = try iter_dir.createFile("y.txt", .{});
    _ = try iter_dir.createFile("z.txt", .{});

    var file_count: usize = 0;
    var iter = iter_dir.iterate();
    while(try iter.next())|entry| {
        if(entry.kind == .file) file_count += 1;
    }
    try expect(file_count == 3);
}
test "-- io write usage --" {
    var list = ArrayList(u8).init(testing.allocator);
    defer list.deinit();
    const str = "Heeeeello world!";
    const bytes_written = try list.writer().write(str);
    try expect(bytes_written == str.len);
    try expect(eql(u8, list.items, str));
}
test "-- io reader usage --" {
    const message = "Hello file!";
    const file = try std.fs.cwd().createFile("test_file2.txt", .{.read=true});
    defer file.close();
    try file.writeAll(message);
    try file.seekTo(0);
    const contents = try file.reader().readAllAlloc(testing.allocator, message.len);
    defer testing.allocator.free(contents);
    try expect(eql(u8, contents, message));
}
fn nextLine(reader: anytype, buffer: []u8) !?[]const u8 {
    const line = (try reader.readUntilDelimiterOrEof(
            buffer, '\n')) orelse return "222";
    if(@import("builtin").os.tag == .windows) {
        return std.mem.trimRight(u8, line, "\r");
    } else return line;
}
test "-- read until next line --" {
    const stdout = std.io.getStdOut();
    const stdin = std.io.getStdIn();
    try std.json.stringify(.{
        .this_is = "an_anonymous_struct",
        .above = true,
        .last_param = "are_options",
    }, .{.whitespace = .indent_2}, stdout.writer());

    try stdout.writeAll(
        \\ Enter your name:
    );
    var buffer: [100]u8 = undefined;
    const input = (try nextLine(stdin.reader(), &buffer)).?;
    try stdout.writer().print(
        " Your name is: \"{s}\"; ",
        .{input},
    );
}
const MyByteList = struct {
    data: [64]u8 = undefined,
    items: []u8 = &[_]u8{},
    const Writer = std.io.Writer(*MyByteList, error{EndOfBuffer}, appendWrite,);
    fn appendWrite(
        self: *MyByteList,
        data: []const u8,
    ) error{EndOfBuffer}!usize {
        if(self.items.len + data.len > self.data.len)
            return error.EndOfBuffer;
        //@memcpy(self.data[self.items.len..(self.items.len + data.len)], data);
        std.mem.copyForwards(u8, self.data[self.items.len..], data);
        self.items = self.data[0..self.items.len + data.len];
        return data.len;
    }
    fn writer(self: *MyByteList) Writer {
        return .{.context = self};
    }
};
test "-- custom writer --" {
    var bytes = MyByteList{};
    _ = try bytes.writer().write("Hello");
    _ = try bytes.writer().write(" Writer!");
    try expect(eql(u8, bytes.items, "Hello Writer!"));
}
test "-- fmt print --" {
    const str = try fmt.allocPrint(testing.allocator, "{any} + {d} = {?}", .{9, 10, 19});
    defer testing.allocator.free(str);
    try expect(eql(u8, str, "9 + 10 = 19"));

    var list = std.ArrayList(u8).init(testing.allocator);
    defer list.deinit();
    try list.writer().print(
        "{}+{}={}",.{6, 6, 12},
        );
    try expect(eql(u8, list.items, "6+6=12"));
}
test "-- array printing --" {
    const str = try fmt.allocPrint(
        testing.allocator,
        "{any}+{any}={any}",
        .{
            @as([]const u8, &[_]u8{1, 4}),
            @as([]const u8, &[_]u8{2, 5}),
            @as([]const u8, &[_]u8{3, 9}),
        });
    defer testing.allocator.free(str);
    try expect(eql(u8, str, "{ 1, 4 }+{ 2, 5 }={ 3, 9 }"));
}
const Dog = struct {
    name: []const u8,
    birth_year: i32,
    death_year: ?i32 = null,
    pub fn format(
        self: Dog,
        comptime _fmt: []const u8,
        options: fmt.FormatOptions,
        writer: anytype
    ) !void {
        _ = _fmt;
        _ = options;
        try writer.print("{s} ({}-",
            .{self.name, self.birth_year});
        if(self.death_year)|year| {
            try writer.print("{d}", .{year});
        }
        try writer.writeAll(")");
    }
};
test "-- custom fmt --" {
    const gogo = Dog{
        .name = "gogo",
        .birth_year = 1988,
        //.death_year = null
    };
    const gogo_string = try fmt.allocPrint(
        testing.allocator,
        "{any}",.{gogo});
    defer testing.allocator.free(gogo_string);
    try expect(eql(u8, gogo_string, "gogo (1988-)"));

    const go2go = Dog{
        .name = "go2go",
        .birth_year = 1222,
        .death_year = 2222,
    };
    const go2go_string = try fmt.allocPrint(
        testing.allocator, "{s}", .{go2go});
    defer testing.allocator.free(go2go_string);
    try expect(eql(u8, go2go_string, "go2go (1222-2222)"));
}
const Place = struct {lat: f32, long: f32};
test "-- json parse --" {
    const parsed = try std.json.parseFromSlice(
        Place, testing.allocator,
        \\{"lat": 40.68, "long": -74.44}
        ,.{});
    defer parsed.deinit();
    const place = parsed.value;
    try expect(place.lat == 40.68);
    try expect(place.long == -74.44);

    const User = struct {name:[]u8, age:u16};
    const parsed2 = try std.json.parseFromSlice(User, testing.allocator,
        \\{ "name": "pipi", "age": 22 }
        , .{});
    defer parsed2.deinit();
    const user = parsed2.value;
    try expect(eql(u8, user.name, "pipi"));
    try expect(user.age == 22);
}
test "-- json stringify --" {
    const x = Place{
        .lat = 51.99, .long = -0.74 };
    var buf: [128]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var string = std.ArrayList(u8).init(fba.allocator());
    try std.json.stringify(x, .{}, string.writer());
    //print("{s}", .{string.items});
    //try expect(eql(u8, string.items,
            //\\{"lat":5.19900016784668e+01,"long":-7.400000095367432e-01}
    //));
}
test "-- random numbers --" {
    var prng = std.rand.DefaultPrng.init(ret: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :ret seed;
    });
    const rand = prng.random();
    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);
    _ = .{a,b,c,d,};
}
test "-- crypto random numbers --" {
    const rand = std.crypto.random;
    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);
    _ = .{a,b,c,d,};
}
fn ticker(step: u8) void {
    while(tick < 6) {
        std.time.sleep(1 * std.time.ns_per_ms);
        tick += @as(isize, step);
    }
}
var tick: isize = 0;
test "-- threading --" {
    const thread = try std.Thread.spawn(.{}, ticker, .{@as(u8,1)});
    _ = thread;
    try expect(tick == 0);
    std.time.sleep(2 * std.time.ns_per_ms);
    try expect(tick > 0);
}
test "-- hashing --" {
    const Point = struct {x: i32, y: i32};
    var map = std.AutoHashMap([*:0]const u8, Point).init(testing.allocator);
    defer map.deinit();
    try map.put("a1", .{.x=1, .y=-4});
    try map.put("a2", .{.x=2, .y=-3});
    try map.put("a3", .{.x=3, .y=-2});
    try map.put("a4", .{.x=4, .y=-1});
    try expect(map.count() == 4);
    var pt = Point{.x = 0, .y = 0};
    var iterator = map.iterator();
    while(iterator.next())|iter| {
        pt.x += iter.value_ptr.x;
        pt.y += iter.value_ptr.y;
    }
    try expect(pt.x == 10);
    try expect(pt.y == -10);
}
test "-- fetchPut --" {
    var map = std.AutoHashMap(u8, i32).init(testing.allocator);
    defer map.deinit();
    try map.put(255, 10);
    const old = try map.fetchPut(255, 100);
    try expect(old.?.value == 10);
    try expect(map.get(255).? == 100);
}
test "-- string hashmap --" {
    var map = std.StringHashMap(enum{cool, uncool}).init(testing.allocator);
    defer map.deinit();
    {
        const key = "gogo";
        try map.put(key, .uncool);
        try map.put("bbbb", .cool);
    }
    try expect(map.get("gogo").? == .uncool);
    try expect(map.get("bbbb").? == .cool);
    var it = map.iterator();
    while(it.next())|kv| {
        print("{s} == {any}\n", .{kv.key_ptr.*, kv.value_ptr.*});
    }
}
test "-- stack --" {
    const string = "(()())";
    var stack = std.ArrayList(u8).init(testing.allocator);
    defer stack.deinit();
    for(string) |chr| {
        if(chr == ')') try stack.append(chr);
    }
    for(string) |chr| {
        if(chr == '(') _ = stack.pop();
    }
}
test "-- sorting --" {
    var data = [_]u8{10,222,1,2,0};
    std.mem.sort(u8, &data, {}, comptime std.sort.asc(u8));
    try expect(eql(u8, &data, &[_]u8{0,1,2,10,222}));
    std.mem.sort(u8, &data, {}, comptime std.sort.desc(u8));
    try expect(eql(u8, &data, &[_]u8{222,10,2,1,0}));
}
test "-- split iterator --" {
    const text = "robust, optimal, reusable, maintainable";
    var iter = std.mem.split(u8, text, ", ");
    try expect(eql(u8, iter.next().?, "robust"));
    try expect(eql(u8, iter.next().?, "optimal"));
    try expect(eql(u8, iter.next().?, "reusable"));
    try expect(eql(u8, iter.next().?, "maintainable"));
    try expect(iter.next() == null);
}
test "-- iterator looping --" {
    var iter = (try std.fs.cwd().openDir(
            ".",.{},)).iterate();
    var file_count: usize = 0;
    while(try iter.next())|entry| {
        if(entry.kind == .file) file_count += 1;
    }
    try expect(file_count > 0);
}
const MyIterator = struct {
    strings: []const []const u8,
    needle: []const u8,
    idx: usize = 0,
    fn next(self: *MyIterator) ?[]const u8 {
        const idx = self.idx;
        for(self.strings[idx..])|str| {
            self.idx += 1;
            if(std.mem.indexOf(u8, str, self.needle))|_| return str;
        }
        return null;
    }
};
test "-- custom iterator --" {
    var iter = MyIterator {
        .strings = &[_][]const u8{"one", "two", "three"},
        .needle = "e",
    };
    try expect(eql(u8, iter.next().?, "one"));
    try expect(eql(u8, iter.next().?, "three"));
    try expect(iter.next() == null);
}
test "-- hex --" {
    var b: [8]u8 = undefined;
    _ = try bufPrint(&b, "{X}", .{4294967294});
    try expect(eql(u8, &b, "FFFFFFFE"));
    _ = try bufPrint(&b, "{x}", .{4294967294});
    try expect(eql(u8, &b, "fffffffe"));
    const bb = try bufPrint(&b, "{}", .{fmt.fmtSliceHexLower("Zig!")});
    try expect(eql(u8, bb, "5a696721"));
}
test "-- decimal float --" {
    var b: [4]u8 = undefined;
    try expect(eql(u8, try bufPrint(&b, "{d}", .{16.5}), "16.5"));
}
test "-- ascii fmt --" {
    var b: [1]u8 = undefined;
    const bb = try bufPrint(&b, "{c}", .{66});
    try expect(eql(u8, bb, "B"));
}
test "-- GB --" {
    var b: [32]u8 = undefined;
    try expect(eql(u8, try bufPrint(&b, "{}", .{fmt.fmtIntSizeDec(1)}), "1B"));
    try expect(eql(u8, try bufPrint(&b, "{}", .{fmt.fmtIntSizeBin(1)}), "1B"));

    try expect(eql(u8, try bufPrint(&b, "{}", .{fmt.fmtIntSizeDec(1024)}), "1.024kB"));
    try expect(eql(u8, try bufPrint(&b, "{}", .{fmt.fmtIntSizeBin(1024)}), "1KiB"));
    try expect(eql(
        u8,
        try bufPrint(&b, "{}", .{fmt.fmtIntSizeDec(1024 * 1024 * 1024)}),
        "1.073741824GB",
    ));
    try expect(eql(
        u8,
        try bufPrint(&b, "{}", .{fmt.fmtIntSizeBin(1024 * 1024 * 1024)}),
        "1GiB",
    ));
}
test "-- binary, octal fmt" {
    var b: [8]u8 = undefined;
    try expect(eql( u8, try bufPrint(&b, "{b}", .{254}), "11111110"));
    try expect(eql(u8, try bufPrint(&b, "{o}", .{254}), "376"));
}
test "-- pointer fmt --" {
    var b: [16]u8 = undefined;
    try expect(eql(u8,
            try bufPrint(&b, "{*}", .{@as(*u8, @ptrFromInt(0xDEADBEEF))}), "u8@deadbeef"));
}
//test "-- scientific --" {
    //var b: [16]u8 = undefined;
    //try expect(eql(
            //u8, try bufPrint(&b, "{e}", .{3.14159}), "3.14159e+00",));
//}
test "-- string fmt --" {
    var b: [6]u8 = undefined;
    const hello: [*:0]const u8 = "hello!";
    const bb = try bufPrint(&b, "{s}", .{hello});
    try expect(eql(u8, bb, "hello!"));
}
test "-- fmt position --" {
    var b: [3]u8 = undefined;
    const bb = try bufPrint(&b, "{0s}{0s}{1s}", .{"a", "b"});
    try expect(eql(u8, bb, "aab"));
}
test "-- fmt fill, alignment, width --" {
    var b: [7]u8 = undefined;
    try expect(eql(u8,
            try bufPrint(&b, "{s:_<5}", .{"hi!"}),
            "hi!__"));
    //print("{s} ", .{try bufPrint(&b, "{s:_^7}", .{"hi!"})});
    try expect(eql(u8,
            try bufPrint(&b, "{s:_^7}", .{"hi!"}),
            "__hi!__"));
    try expect(eql(u8,
            try bufPrint(&b, "{s:_>5}", .{"hi!"}),
            "__hi!"));
}
test "-- precision --" {
    var b: [4]u8 = undefined;
    try expect(eql(u8,
            try bufPrint(&b, "{d:.2}", .{3.1415926}),
            "3.14"));
}
const Data = extern struct { a: i32, b: u8, c: f32, d: bool, e: bool };
test "-- extern structs --" {
    const x = Data{
        .a = 10005,
        .b = 42,
        .c = -10.5,
        .d = false, .e = true
    };
    const z = @as([*]const u8, @ptrCast(&x));
    const p_a: *const i32 = @as(*const i32, @ptrCast(@alignCast(z)));
    try expect(p_a.* == 10005);
    const p_b: *const u8 = @as(*const u8, @ptrCast(@alignCast(z+4)));
    try expect(p_b.* == 42);
    const p_c: *const f32 = @as(*const f32, @ptrCast(@alignCast(z+8)));
    try expect(p_c.* == -10.5);
    const p_d: *const bool = @as(*const bool, @ptrCast(@alignCast(z+12)));
    try expect(p_d.* == false);
    const p_e = @as(*const bool, @ptrCast(@alignCast(z+13)));
    try expect(p_e.* == true);
    try expect(@sizeOf(Data) == 16);
}
fn total_align(a: *align(64) const [64]u8) u32 {
    var ret: u32 = 0;
    for(a)|n| ret += n;
    return ret;
}
test "-- passing aligned data --" {
    //const x align(64) = [_]u8{10} ** 64;
    const x align(64) = [1]u8{10} ** 64;
    //const x: [64]u8 align(64) = [_]u8{10} ** 64;
    try expect(total_align(&x) == 640);

    const a: u32 align(16) = 5;
    //const a align(8) = @as(u32,5);
    try expect(@TypeOf(&a) == *align(16) const u32);
    try expect(@sizeOf(@TypeOf(a)) == 4);
}
const MoveMentState = packed struct {
    running: bool,
    crouching: bool,
    jumping: bool,
    in_air: bool,
    in_air2: bool = true,
};
test "-- packed struct size --" {
    try expect(@sizeOf(MoveMentState) == 1);
    print("=={d}", .{@sizeOf(MoveMentState)});
    try expect(@bitSizeOf(MoveMentState) == 5);
    const state = MoveMentState {
        .running = true,
        .crouching = true,
        .jumping = true,
        .in_air = true
    };
    try expect(@bitSizeOf(@TypeOf(state)) == 5);
}
test "-- pointer arithmetic with many-item pointer and slice --" {
    const array = [_]i32{ 1, 2, 3, 4 };
    var ptr: [*]const i32 = &array;
    try expect(ptr[0] == 1);
    ptr += 1;
    try expect(ptr[0] == 2);
    try expect(ptr[1..] == ptr + 1);

    var start: usize = 0; _ = &start;
    var slice = array[start..array.len];
    try expect(slice[0] == 1);
    try expect(slice.len == 4);
    slice.ptr += 1;
    try expect(slice[0] == 2);
    try expect(slice.len == 4);
}
test "pointer slicing" {
    var array = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    var start: usize = 2; // var to make it runtime-known
    _ = &start; // suppress 'var is never mutated' error
    const slice = array[start..4];
    try expect(slice.len == 2);

    try expect(array[3] == 4);
    slice[1] += 1;
    try expect(array[3] == 5);
}
test "-- bit aligned pointers --" {
    var x = MoveMentState {
        .running = false,
        .crouching = false,
        .jumping = false,
        .in_air = false
    };
    const running = &x.running;
    running.* = true;
    const crouching = &x.crouching;
    crouching.* = true;
    try expect(@TypeOf(running) == *align(1:0:1) bool);
    try expect(@TypeOf(crouching) == *align(1:1:1) bool);
    try expect(meta.eql(x, .{
        .running = true,
        .crouching = true,
        .jumping = false,
        .in_air = false,
    }));
}
fn userFactory(data: anytype) User2 {
    const T = @TypeOf(data);
    return .{
        .id = if(@hasField(T, "id")) data.id else 0,
        .power = if(@hasField(T, "power")) data.power else 0,
        .active = if(@hasField(T, "active")) data.active else false,
        .name = if(@hasField(T, "name")) data.name else "",
    };
}
pub const User2 = struct {
    id: u64,
    power: u64,
    active: bool,
    name: []const u8,
    fn isMe() bool {
        return true;
    }
};
const User1 = struct {
    name: []const u8,
    age: u16,
};
test "-- @TypeOf @hasField @hasDecl anytype --" {
    const user = User1{.name = "aaaa222", .age = 10};
    const user2 = userFactory(user);
    // @hasDecl can verify var and func
    try expect(@hasDecl(@TypeOf(user), "isMe") == false);
    try expect(@hasDecl(@TypeOf(user2), "isMe") == true);
    try expect(@TypeOf(user2) == User2);
    try expect(eql(u8, user2.name, "aaaa222"));
}
const a_user = User1 {.name = "a_user", .age = 6};
const b_user = User1 {.name = "b_user", .age = 12};
test "-- @field get var --" {
    const a = @field(@This(), "a_user");
    const pname = &a.name;
    try expect(eql(u8, a.name, "a_user"));
    try expect(@field(@This(), "a_user").age == 6);
    const a_ptr: *const User1 = @fieldParentPtr("name", pname);
    try expect(a_ptr.age == a.age);

    const aaa = ("a_user")[0..];
    print("\n'@this() = {any} field'\n", .{@This()});
    print("'string = {any}' ", .{@TypeOf(aaa)});
    try expect(@TypeOf(aaa) == *const [6:0]u8);
    const names = [_][]const u8{"a", "b"};
    inline for(names)|name| {
        //const user_name = (name ++ "_user")[0..];
        const user_name = name ++ "_user";
        try expect(@TypeOf(user_name) == @TypeOf(user_name[0..]));
        const user = @field(@This(), user_name);
        try expect(eql(u8, user.name, user_name));
    }
}
fn printSequece(my_seq: anytype) void {
    const my_typeinfo = @typeInfo(@TypeOf(my_seq));
    switch(my_typeinfo) {
        .Array => {
            print("\nArray: ", .{});
            for(my_seq)|s| {
                print("{any}", .{s});
            }
            print(", size: {}", .{my_seq.len});
        },
        .Pointer => {
            const my_sentinel = sentinel(@TypeOf(my_seq));
            print("\nMany-item pointer: ", .{});
            var i: usize = 0;
            while(my_seq[i] != my_sentinel):(i += 1) {
                print("{any}", .{my_seq[i]});
            }
            print(", size: {}", .{i});
        },
        else => unreachable,
    }
    print("; ", .{});
}
test "-- array or pointer typeinfo and sentinel --" {
    var nums = [_:5]u32 {1,2,3,4,5,6};
    const ptr: [*:5]u32 = &nums;

    nums[3] = 5;
    printSequece(nums);
    printSequece(ptr);

    var nums2 = [_:null]?u32 {1,2,3,4,5,6};
    const ptr2: [*:null]?u32 = &nums2;

    nums2[3] = null;
    printSequece(nums2);
    printSequece(ptr2);
}
test "-- @\"name\" -- " {
    const @"55_cows": i32 = 55;
    const @"isn't true": bool = false;
    print("Sweet freedom: {}, {}.\n", .{
        @"55_cows",
        @"isn't true",
    });

    const foo = .{true, false};
    try expect(foo.@"0" == true);
    try expect(foo.@"1" == false);
    print("foo = {}, {};", foo);
}
fn printTuple(tuple: anytype) void {
    _ = @field(tuple, "0");
    comptime try expect(@field(tuple, "1") == false);
    comptime {
        try expect(@field(tuple, "2") == 42);
        try expect(@field(tuple, "3") == 3.14159202e+00);
    }

    const fields = @typeInfo(@TypeOf(tuple)).Struct.fields;
    inline for (fields) |field| {
        print("\n\"{s}\"({any}):{any} ", .{
            field.name,
            field.type,
            @field(tuple, field.name),
        });
    }
}
test "-- @typeInfo @field --" {
    const foo = .{
        true,
        false,
        @as(i32, 42),
        @as(f32, 3.141592),
    };
    printTuple(foo);
    const nothing = .{};
    print("\n", nothing);
}
test "-- anonymous list and tuple --" {
    const foo: [3]u32 = .{10, 20, 30}; // list
    const bar = .{10, 20, 30}; // tuple
    const con: struct{u32,u32,u32} = .{30, 20, 10};
    print("\nfoo: {any}", .{@TypeOf(foo)});
    print("\nbar: {any}", .{@TypeOf(bar)});
    _ = con;
    //print("\ncon: {any}", .{@TypeOf(con)}); // too longer so comment
}
test "-- inline else switch --" {
    const v = Direction.east;
    switch(v) {
        .north => print("\nnorth ", .{}),
        inline .south => print("\nsouth ", .{}),
        inline else => print("\nI dont know direction! ",.{}),
    }
}
pub extern "c" fn printf(format: [*:0]const u8, ...) c_int;
test "-- cImport cInclude and call c function --" {
    //var a: [32]u8 = .{0} ** 32;
    //var a = [_]u8{0} ** 32;
    var a = [1:0]u8{0} ** 32;
    _ = cc.sprintf(@ptrCast(&a), "===Hello c world!===");
    print("\n{s} std.debug.print", .{a});
    //_ = std.c.printf("%s std.c.printf", &a);
    _ = printf("%s std.c.printf", &a);
}
test "-- bit manipulation -- " {
    //const numOne: u8 = 15;        //   =  0000 1111
    //const numTwo: u8 = 245;       //   =  1111 0101
    //const res1 = numOne >> 4;     //   =  0000 0000 - shift right
    //const res2 = numOne << 4;     //   =  1111 0000 - shift left
    //const res3 = numOne & numTwo; //   =  0000 0101 - and
    //const res4 = numOne | numTwo; //   =  1111 1111 - or
    //const res5 = numOne ^ numTwo; //   =  1111 1010 - xor
    var x: u8 = 0b1111;
    var y: u8 = 0b1111_0000;
    x ^= y; // 1111 1111
    y ^= x; // 0000 1111
    x ^= y; // 1111 0000
    try expect(x == 0xF0);
    try expect(y == 0x0F);
}
test "-- tokenizeAny --" {
    const poem =
        \\My name is Ozymandias, King of Kings;
        \\Look on my Works, ye Mighty, and despair!
    ;
    var it = std.mem.tokenizeAny(u8, poem, " ,;!\n");
    var cnt: usize = 0;

    print("\n", .{});
    while (it.next()) |word| {
        cnt += 1;
        print("{s}|", .{word});
    }
    print("\nThis little poem has {d} words!\n", .{cnt});
}
test "-- indexOfSentinel, indexOf --" {
    const text = "12345678asdfgh";
    var idx = mem.indexOfSentinel(u8, '6', @ptrCast(text)); //[*:'6']const u8
    try expect(idx == 5);
    idx = mem.indexOfSentinel(u8, 0, text);
    try expect(idx == text.len);

    const idx2 = mem.indexOf(u8, text, "78");
    try expect(idx2 == 6);
}
test "-- sliceTo --" {
    const text = "12345678asdfgh";
    var str = mem.sliceTo(text, '3');
    //_ = idx;
    print("idx = {s} ", .{str});
    //try expect(idx == 5);
    print("{s}  ", .{text[0..][2..5]});
    str = mem.sliceTo(text, 0);
    try expect(str.len == text.len);

    var array: [5]u16 = [_]u16{ 1, 2, 3, 4, 5 };
    try expectEqual(@as(usize, 5), mem.sliceTo(&array, 0).len);
    try expectEqual(@as(usize, 3), mem.sliceTo(array[0..3], 0).len);
    try expectEqual(@as(usize, 2), mem.sliceTo(&array, 3).len);
    try expectEqual(@as(usize, 2), mem.sliceTo(array[0..3], 3).len);

    const sentinel_ptr = @as([*:5]u16, @ptrCast(&array));
    try expectEqual(@as(usize, 2), mem.sliceTo(sentinel_ptr, 3).len);
    try expectEqual(@as(usize, 4), mem.sliceTo(sentinel_ptr, 99).len);

    const c_ptr = @as([*c]u16, &array);
    try expectEqual(@as(usize, 2), mem.sliceTo(c_ptr, 3).len);

    const slice: []u16 = &array;
    try expectEqual(@as(usize, 2), mem.sliceTo(slice, 3).len);
    try expectEqual(@as(usize, 5), mem.sliceTo(slice, 99).len);

    const sentinel_slice: [:5]u16 = array[0..4 :5];
    try expectEqual(@as(usize, 2), mem.sliceTo(sentinel_slice, 3).len);
    try expectEqual(@as(usize, 4), mem.sliceTo(sentinel_slice, 99).len);
}
test "--- zeroes, zeroInit ---" {
    const I = struct {
        d: f64,
    };
    const z = mem.zeroes(I);
    try testing.expectEqual(I{.d=0}, z);

    const S = struct {
        a: u32,
        b: ?bool,
        c: I,
        e: [3]u8,
        f: i64 = -1,
    };
    const s = mem.zeroInit(S, .{
        .a = 42,
        .c = .{6},
    });
    try testing.expectEqual(S{
        .a = 42,
        .b = null,
        .c = .{
            .d = 6,
        },
        .e = [3]u8{ 0, 0, 0 },
        .f = -1,
    }, s);

    const Bar = struct {
        foo: u32 = 666,
        bar: u32 = 420,
    };
    const b = mem.zeroInit(Bar, .{66});
    try testing.expectEqual(Bar{
        .foo = 66,
        .bar = 420,
    }, b);
}
//pointer coerce const optional
test "-- cast *[1][*]const u8 to [*]const ?[*]const u8 --" {
    const name = [1][*]const u8{"lol"};
    const x: [*]const ?[*]const u8 = &name;
    const z = mem.sliceTo( @as([*:0]const u8, @ptrCast(x[0].?)), 0 );
    try expect(eql(u8, z, "lol"));
}
//Type Coercion: Slices, Arrays and Pointers
test "-- *const [N]T to []const T --" {
    //const x: [5]u8 = [5]u8{'h','e','l','l',111};
    const x: [5]u8 = "hello".*;
    const x1: []const u8 = "hello";
    const x2: []const u8 = &[5]u8{'h','e','l','l',111};
    print("{s}: ",.{x});
    print("{s} ",.{&x});
    try expect(eql(u8, &x, x1));
    try expect(eql(u8, x1, x2));
    const y: ?[]const f32 = &[2]f32{1.2, 3.4};
    try expect(y.?[0] == 1.2);
}
test "-- *const [N]T to ?[]const T --" {
    const x1: ?[]const u8 = "hello";
    const x2: ?[]const u8 = &[5]u8{'h','e','l','l',111};
    try expect(eql(u8, x1.?, x2.?));
}
test "-- anyerror and *const [N]T to E![]const T --" {
    const x1: anyerror![]const u8 = "hello";
    const x2: anyerror![]const u8 = &[5]u8{'h','e','l','l',111};
    try expect(eql(u8, try x1, try x2));
    const y: anyerror![]const f32 = &[2]f32{1.2, 3.4};
    try expect((try y)[0] == 1.2);
}
test "-- *[N]T to [] T --" {
    const buf: [5]u8 = "hello".*;
    const x: []const u8 = "hello";
    //const x: []const u8 = &buf;
    try expect(eql(u8, &buf, x));
    try expect(eql(u8, &buf, "hello"));
    //print("{any}\n",.{@TypeOf(&buf)});
    try expectEqual(@TypeOf(&buf), *const[5]u8);
    try expectEqual(@TypeOf(x), []const u8);
    try expect(eql(u8, x, "hello"));

    const buf2 = [2]f32{1.2, 3.4};
    //const x2: [] f32 = &buf2;
    const x2: []const f32 = &buf2;
    try expect(eql(f32, x2, &[2]f32{1.2,3.4}));
}
test "-- *T to *[1]T --" {
    var x: i32 = 1234;
    const y: *[1]i32 = &x;
    //const z: [*]i32 = y;
    const z: [*]i32 = @ptrCast(&x);
    try expect(z[0] == x);
    try expect(z == y);
}
test "-- @typeName --" {
    print("\n===typeName = {s} ", .{@typeName(@TypeOf( &[_][]const u8{"www", "222"}))});
    // ===typeName = *const [2][]const u8
    try expect(eql(u8, @typeName(i32), "i32"));
}
test "-- replace -- " {
    //var output = [_]u8{0} ** 32;
    var output = [1]u8{0} ** 32;
    const buf = "what's wrong with me.";
    const replacements = mem.replace(u8, buf, "me", "you", output[0..]);
    const expected = "what's wrong with you.";
    try expect(replacements == 1);
    try expectEqualSlices(u8, expected, output[0..expected.len]);
}
test "-- reverse --" {
    var arr = [_]i32{1,2,3,4,5};
    mem.reverse(i32, &arr);
    //mem.rotate(i32, arr[0..]);
    try expect(eql(i32, &arr, &[_]i32{5,4,3,2,1}));
}
test "-- rotate --" {
    var arr = [_]i32{1,2,3,4,5};
    mem.rotate(i32, &arr, 2);
    //mem.rotate(i32, arr[0..], 2);
    try expect(eql(i32, &arr, &[_]i32{3,4,5,1,2}));
}
test "-- minMax indexOfMinMax --" {
    const minimum = mem.min(u8, "abcdefg");
    const maximum = mem.max(u8, "abcdefg");
    try expectEqual(@as(u8, 'a'), minimum);
    try expectEqual(@as(u8, 'g'), maximum);

    const minmax = mem.minMax(u8, "bcdef");
    try expectEqual('b', minmax[0]);
    try expectEqual('f', minmax[1]);

    try expectEqual(mem.indexOfMin(u8,"abcdefg"), 0);
    try expectEqual(mem.indexOfMin(u8,"gbcdefa"), 6);
    try expectEqual(mem.indexOfMin(u8,"a"), 0);

    try expectEqual(mem.indexOfMax(u8,"abcdefg"), 6);
    try expectEqual(mem.indexOfMax(u8,"gbcdefa"), 0);
    try expectEqual(mem.indexOfMax(u8,"a"), 0);

    try expectEqual(.{ 0, 6 }, mem.indexOfMinMax(u8, "abcdefg"));
    try expectEqual(.{ 1, 0 }, mem.indexOfMinMax(u8, "gabcdef"));
    try expectEqual(.{ 0, 0 }, mem.indexOfMinMax(u8, "a"));
}
test "-- tokenize --" {
    {
        var it = mem.tokenizeAny(u8, "   abc def    ghi  ", " ");
        try expect(eql(u8, it.next().?, "abc"));
        try expect(eql(u8, it.next().?, "def"));
        try expect(eql(u8, it.next().?, "ghi"));
        it.reset();
        try expect(eql(u8, it.next().?, "abc"));
        try expect(eql(u8, it.next().?, "def"));
        try expect(eql(u8, it.next().?, "ghi"));
        try expect(it.next() == null);
    }
    {
        var it = mem.tokenizeAny(u8, "abc<> def<>,>ghi|>/>jkl><", "></|, ");
        try expect(eql(u8, it.next().?, "abc"));
        try expect(eql(u8, it.next().?, "def"));
        try expect(eql(u8, it.next().?, "ghi"));
        try expect(eql(u8, it.next().?, "jkl"));
        try expect(it.next() == null);
        try expect(it.next() == null);
    }
    {
        var it = mem.tokenizeSequence(u8, "abc<>def<><>ghi><>jkl><", "<>");
        try expect(eql(u8, it.next().?, "abc"));
        try expect(eql(u8, it.next().?, "def"));
        try expect(eql(u8, it.next().?, "ghi>"));
        try expect(eql(u8, it.next().?, "jkl><"));
    }
}
test "-- count --" {
    try expect(mem.count(u8, "hello world!", "hello") == 1);
    try expect(mem.count(u8, "   abcabc   abc", "abc") == 3);
    try expect(mem.count(u8, "udexdcbvbruhasdrw", "bruh") == 1);
    try expect(mem.count(u8, "foo bar", "o bar") == 1);
    try expect(mem.count(u8, "foofoofoo", "foo") == 3);
    try expect(mem.count(u8, "fffffff", "ff") == 3);
    try expect(mem.count(u8, "owowowu", "owowu") == 1);
}
test "-- trim --" {
    try expectEqualSlices(u8, "foo\n ", mem.trimLeft(u8, " foo\n ", " \n"));
    try expectEqualSlices(u8, " foo", mem.trimRight(u8, " foo\n ", " \n"));
    try expectEqualSlices(u8, "foo", mem.trim(u8, " foo\n ", " \n"));
    try expectEqualSlices(u8, "foo", mem.trim(u8, "foo", " \n"));
}
test "-- len --" {
    var array: [5]u16 = [_]u16{ 1, 2, 0, 4, 5 };
    const ptr = @as([*:4]u16, array[0..3 :4]);
    try testing.expect(mem.len(ptr) == 3);
    const c_ptr = @as([*c]u16, ptr);
    try testing.expect(mem.len(c_ptr) == 2);
}
test "-- span --" {
    // Span equal types
    //Span([*:1]u16) == [:1]u16);
    //Span(?[*:1]u16) == ?[:1]u16);
    //Span([*:1]const u8) == [:1]const u8);
    //Span(?[*:1]const u8) == ?[:1]const u8);
    //Span([*c]u16) == [:0]u16);
    //Span(?[*c]u16) == ?[:0]u16);
    //Span([*c]const u8) == [:0]const u8);
    //Span(?[*c]const u8) == ?[:0]const u8);

    // span equal variable
    var array: [5]u16 = [_]u16{ 1, 2, 3, 4, 5 };
    const ptr = @as([*:3]u16, array[0..2 :3]);
    try expect(eql(u16, mem.span(ptr), &[_]u16{ 1, 2 }));
    try expectEqual(@as(?[:0]u16, null), mem.span(@as(?[*:0]u16, null)));
}
test "-- reverse Iterator --" {
    var it = mem.reverseIterator("abc");
    try expect('c' == it.next().?);
    try expect('b' == it.next().?);
    try expect('a' == it.next().?);
    try expect(null == it.next());
}
test "-- static local variables --" {
    const S = struct {
        xx: i32 = 0, // in S field
        var s_xx: i32 = 22; // static var, not in S field
    };
    const s = S {.xx = 10};
    S.s_xx = 100;
    print("--{any}", .{s});
    try expect(@hasDecl(S, "xx") == false);
    try expect(@hasDecl(S, "s_xx") == true);

    try expect(@hasField(S, "xx") == true);
    try expect(@hasField(S, "s_xx") == false);

    try expect(@field(s, "xx") == 10);
    //try expect(@field(s, "s_xx") == 100); //error: s_xx is static var in S
}
fn echoTest(val: anytype) void {
    print("\n-- {any} ", .{val.getd()});
}
test "-- anytypes template --" {
    const S1 = struct {d: i32 = 0, fn getd(e:@This())i32 {return e.d;}};
    const S2 = struct {d: f32 = 0.6, fn getd(e:@This())f32 {return e.d;}};
    const s1 = S1{};
    const s2 = S2{};
    echoTest(s1);
    echoTest(s2);
}
test "-- itoa atoi parseInt --" {
    try expect((try parseInt(i32, "-10", 10)) == -10);
    try expect((try parseInt(i32, "+10", 10)) == 10);
    try expect((try parseInt(u32, "10", 10)) == 10);
    try expect((try parseInt(i8, "101", 2)) == 0b101);
    try expect((try parseInt(i8, "-101", 2)) == -0b101);
    try expect((try parseInt(i8, "11", 8)) == 9);
    try expect((try parseInt(i8, "-11", 8)) == -9);
    try expectError(error.Overflow, parseInt(u32, "-10", 10));
    try expectError(error.InvalidCharacter, parseInt(u32, " 10", 10));
    try expectError(error.InvalidCharacter, parseInt(u32, "10 ", 10));
    try expectError(error.InvalidCharacter, parseInt(u32, "_10_", 10));
    try expectError(error.InvalidCharacter, parseInt(u32, "0x_10_", 10));
    try expectError(error.InvalidCharacter, parseInt(u32, "0x10", 10));
    try expect((try parseInt(u8, "255", 10)) == 255);
    try expectError(error.Overflow, parseInt(u8, "256", 10));

    try expect((try parseInt(u8, "-0", 10)) == 0);
    try expect((try parseInt(u8, "+0", 10)) == 0);

    try expect((try parseInt(i1, "-1", 10)) == math.minInt(i1));
    try expect((try parseInt(i8, "-128", 10)) == math.minInt(i8));
    try expect((try parseInt(i43, "-4398046511104", 10)) == math.minInt(i43));

    try expectError(error.InvalidCharacter, parseInt(u32, "", 10));
    try expectError(error.InvalidCharacter, parseInt(u32, "-", 10));
    try expectError(error.InvalidCharacter, parseInt(i32, "+", 10));
    try expectError(error.InvalidCharacter, parseInt(i32, "-", 10));

    try expect((try parseInt(i32, "111", 0)) == 111);
    try expect((try parseInt(i32, "1_1_1", 0)) == 111);
    try expect((try parseInt(i32, "0b111", 0)) == 7);
    try expect((try parseInt(i32, "+0B1_11", 0)) == 7);
    try expect((try parseInt(i32, "-0b1_1_1", 0)) == -7);
    try expect((try parseInt(i32, "+0o11_1", 0)) == 73);
    try expect((try parseInt(i32, "-0O1_11", 0)) == -73);
    try expect((try parseInt(i32, "+0x111", 0)) == 273);
    try expect((try parseInt(i32, "-0X1_11", 0)) == -273);

    try expectError(error.InvalidCharacter, parseInt(u32, "0b", 0));
    try expectError(error.InvalidCharacter, parseInt(u32, "0o", 0));
    try expectError(error.InvalidCharacter, parseInt(u32, "0x", 0));

    try expectEqual(@as(i2, -2), try parseInt(i2, "-10", 2));
    try expectEqual(@as(i4, -8), try parseInt(i4, "-10", 8));
    try expectEqual(@as(i5, -16), try parseInt(i5, "-10", 16));
}
test "-- parseFloat --" {
    inline for ([_]type{ f16, f32, f64, f128 }) |T| {
        try expectError(error.InvalidCharacter, parseFloat(T, ""));
        try expectError(error.InvalidCharacter, parseFloat(T, "   1"));
        try expectError(error.InvalidCharacter, parseFloat(T, "1abc"));
        try expectError(error.InvalidCharacter, parseFloat(T, "+"));
        try expectError(error.InvalidCharacter, parseFloat(T, "-"));

        try expectEqual(try parseFloat(T, "0"), 0.0);
        try expectEqual(try parseFloat(T, "0."), 0.0);
        try expectEqual(try parseFloat(T, "+0"), 0.0);
        try expectEqual(try parseFloat(T, "-0"), 0.0);

        try expectEqual(try parseFloat(T, "0e0"), 0);
        try expectEqual(try parseFloat(T, "2e3"), 2000.0);
        try expectEqual(try parseFloat(T, "1e0"), 1.0);
        try expectEqual(try parseFloat(T, "-2e3"), -2000.0);
        try expectEqual(try parseFloat(T, "-1e0"), -1.0);
        try expectEqual(try parseFloat(T, "1.234e3"), 1234);

        const epsilon = comptime math.floatEps(T);
        //const min_value = comptime math.floatMin(T);
        try expect(math.approxEqAbs(T, try parseFloat(T, "3.141"), 3.141, epsilon));
        try expect(math.approxEqAbs(T, try parseFloat(T, "-3.141"), -3.141, epsilon));

        try expectEqual(try parseFloat(T, "1e-5000"), 0);
        try expectEqual(try parseFloat(T, "1e+5000"), std.math.inf(T));

        try expectEqual(try parseFloat(T, "0.4e0066999999999999999999999999999999999999999999999999999"), std.math.inf(T));
        try expect(math.approxEqAbs(T, try parseFloat(T, "0_1_2_3_4_5_6.7_8_9_0_0_0e0_0_1_0"), @as(T, 123456.789000e10), epsilon));

        try expectError(error.InvalidCharacter, parseFloat(T, "0123456.789000e_0010")); // cannot occur immediately after exponent
        try expectError(error.InvalidCharacter, parseFloat(T, "_0123456.789000e0010")); // cannot occur before any digits
        try expectError(error.InvalidCharacter, parseFloat(T, "0__123456.789000e_0010")); // cannot occur twice in a row
        try expectError(error.InvalidCharacter, parseFloat(T, "0123456_.789000e0010")); // cannot occur before decimal point
        try expectError(error.InvalidCharacter, parseFloat(T, "0123456.789000e0010_")); // cannot occur at end of number
        try expectError(error.InvalidCharacter, parseFloat(T, ".")); // At least one digit is required.
        try expectError(error.InvalidCharacter, parseFloat(T, ".e1")); // At least one digit is required.
        try expectError(error.InvalidCharacter, parseFloat(T, "0.e")); // At least one digit is required.

        try expect(math.approxEqAbs(T, try parseFloat(T, "123142.1"), 123142.1, epsilon));
        try expect(math.approxEqAbs(T, try parseFloat(T, "-123142.1124"), @as(T, -123142.1124), epsilon));
        try expect(math.approxEqAbs(T, try parseFloat(T, "0.7062146892655368"), @as(T, 0.7062146892655368), epsilon));
        try expect(math.approxEqAbs(T, try parseFloat(T, "2.71828182845904523536"), @as(T, 2.71828182845904523536), epsilon));
    }
}
test "-- parseIntSizeSuffix --" {
    try expect(try parseIntSizeSuffix("2", 10) == 2);
    try expect(try parseIntSizeSuffix("2B", 10) == 2);
    try expect(try parseIntSizeSuffix("2kB", 10) == 2000);
    try expect(try parseIntSizeSuffix("2k", 10) == 2000);
    try expect(try parseIntSizeSuffix("2KiB", 10) == 2048);
    try expect(try parseIntSizeSuffix("2Ki", 10) == 2048);
    try expect(try parseIntSizeSuffix("aKiB", 16) == 10240);
    try expect(parseIntSizeSuffix("", 10) == error.InvalidCharacter);
    try expect(parseIntSizeSuffix("2iB", 10) == error.InvalidCharacter);
}
test "-- clamp --" {
    try expect(math.clamp(@as(i32, -1), @as(i32, -4), @as(i32, 7)) == -1);
    try expect(math.clamp(@as(i32, -5), @as(i32, -4), @as(i32, 7)) == -4);
    try expect(math.clamp(@as(i32, 8), @as(i32, -4), @as(i32, 7)) == 7);

    try expect(math.clamp(@as(f32, 1.1), @as(f32, 0.0), @as(f32, 1.0)) == 1.0);
    try expect(math.clamp(@as(f32, -127.5), @as(f32, -200), @as(f32, -100)) == -127.5);
    // Mix of comptime and non-comptime
    var i: i32 = 1; _ = &i;
    try testing.expect(std.math.clamp(i, 0, 1) == 1);
}
test "-- @floor @ceil @trunc @round --" {
    try expect(@floor(5.99999) == 5);
    try expect(@ceil(5.11111) == 6);
    try expect(@trunc(5.99999) == 5);
    try expect(@round(5.4) == 5);
    try expect(@round(5.5) == 6);
}
test "-- @unionInit can modify a pointer value --" {
    if (builtin.zig_backend == .stage2_c) return error.SkipZigTest; // TODO
    const UnionInitEnum = union(enum) {
        Boolean: bool,
        Byte: u8,
    };
    var value: UnionInitEnum = undefined;
    const value_ptr = &value;

    value_ptr.* = @unionInit(UnionInitEnum, "Boolean", true);
    try expect(value.Boolean == true);

    value_ptr.* = @unionInit(UnionInitEnum, "Byte", 2);
    try expect(value.Byte == 2);
}
test "-- math Overflow --" {
    var byte: u8 = 255;
    byte = if (math.add(u8, byte, 1)) |result| result else |err| blk: {
        print("unable to add one: {s}!!! ", .{@errorName(err)});
        break :blk 66;
    };
    try expect(byte == 66);
}
test "-- destructure array --" {
    var z: u32 = undefined;
    const x, var y, z = [3]u32{ 1, 2, 3 };
    y += 10;
    try expectEqual(1, x);
    try expectEqual(12, y);
    try expectEqual(3, z);
}
test "-- destructure vector --" {
    // Comptime-known values are propagated as you would expect.
    const x, const y = @Vector(2, u32){ 1, 2 };
    comptime assert(x == 1);
    comptime assert(y == 2);
}
test "-- destructure tuple --" {
    var runtime: u32 = undefined;
    runtime = 123;
    const x, const y = .{ 42, runtime };
    // The first tuple field is a `comptime` field, so `x` is comptime-known even
    // though `y` is runtime-known.
    comptime assert(x == 42);
    try expectEqual(123, y);
}
test "-- @errorCast error set" {
    const err: error{Foo, Bar} = error.Foo;
    const casted: error{Foo} = @errorCast(err);
    try testing.expectEqual(error.Foo, casted);
}

test "-- @errorCast error union" {
    const err: error{Foo, Bar}!u32 = error.Foo;
    const casted: error{Foo}!u32 = @errorCast(err);
    try testing.expectError(error.Foo, casted);
}

test "-- @errorCast error union payload" {
    const err: error{Foo, Bar}!u32 = 123;
    const casted: error{Foo}!u32 = @errorCast(err);
    try testing.expectEqual(123, casted);
}

