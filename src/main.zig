const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

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

    std.debug.print("---------------{s}---------------\n", .{"For"});
    //character literals are equivalent to integer literals
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string, 0..) |character, index| {
        std.debug.print("character:{c}; ascii:{d}; index:{d}\n", .{ character, character, index });
    }
    std.debug.print("---------------{s}---------------\n", .{"For"});
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

test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;
    // Just like JS `for (let i)`
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 55);
}

test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += i;
    }
    try expect(sum == 4);
}

test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) break;
        sum += i;
    }
    try expect(sum == 1);
}

test "for" {
    //character literals are equivalent to integer literals
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string, 0..) |character, index| {
        _ = character;
        _ = index;
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}

fn addFive(x: u16) u32 {
    return x + 5;
}

test "function" {
    const y = addFive(10);
    try expect(@TypeOf(y) == u32);
    try expect(@TypeOf(y) != u16);
    try expect(y == 15);
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursion" {
    const x = fibonacci(10);
    try expect(x == 55);
}

test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        // When there are multiple defers in a single block, they are executed in reverse order.
        defer x += 2; // Runs second
        defer x /= 2; // Runs first
    }
    try expectEqual(4.5, x);
}
