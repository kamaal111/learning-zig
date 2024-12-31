const std = @import("std");
const expect = std.testing.expect;

pub fn main() !void {
    std.debug.print("---------------{s}---------------\n", .{"Hello World"});
    std.debug.print("Hello, {s}!\n", .{"World"});
    std.debug.print("---------------{s}---------------\n", .{"Hello World"});

    std.debug.print("---------------{s}---------------\n", .{"Assignment"});
    const constant: i32 = 5; // signed 32-bit constant
    var variable: u32 = 5000; // unsigned 32-bit variable
    variable = 2222;

    // @as performs an explicit type coercion
    const inferred_constant = @as(i32, 5);
    var inferred_variable = @as(u32, 5000);
    inferred_variable = variable;
    variable = 3333;

    var a: i32 = undefined;

    std.debug.print("{d}-{d}--{d}-{d}---{d}\n", .{
        constant,
        variable,
        inferred_constant,
        inferred_variable,
        a,
    });
    a = 33;
    std.debug.print("a:{d}\n", .{a});
    std.debug.print("---------------{s}---------------\n", .{"Assignment"});

    std.debug.print("---------------{s}---------------\n", .{"Arrays"});
    const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    const length = array.len; // 5
    std.debug.print("word:{s}; length:{d}\n", .{ array, length });
    std.debug.print("---------------{s}---------------\n", .{"Arrays"});
}

test "always succeeds" {
    try expect(true);
}

test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 1);
}

test "while" {
    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
    }
    try expect(i == 128);
}
