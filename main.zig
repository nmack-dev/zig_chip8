//--------------------------------------------------------------//
// Imports
//--------------------------------------------------------------//
const std: type = @import("std");
const mem: type = @import("memory.zig").memory;
const expect = std.testing.expect;

//--------------------------------------------------------------//
// Types
//--------------------------------------------------------------//
const Nibble = enum(u8) {
    first = 1,
    second = 2,
    third = 3,
    fourth = 4,
};

//--------------------------------------------------------------//
// Globals
//--------------------------------------------------------------//
var chip8_mem = mem.init();

//--------------------------------------------------------------//
// Comptime functions
//--------------------------------------------------------------//
fn nibble(data: u16, nib: Nibble) u8 {
    return (data >> (16 - (4 * nib))) & 0xF;
}

//--------------------------------------------------------------//
// Emulation functions
//--------------------------------------------------------------//
fn ret() void {
    chip8_mem.pc = chip8_mem.stack.pop();
}

fn cls() void {
    // TODO need screen impl
}

fn jp_addr(data: u16) void {
    chip8_mem.pc = data & 0x0FFF;
}

fn call(data: u16) void {
    chip8_mem.stack.append(chip8_mem.pc);
    chip8_mem.pc = data & 0x0FFF;
}

fn se_byte(data: u16) void {
    if (chip8_mem.reg[comptime nibble(data, Nibble.second)] == (data & 0xFF)) {
        chip8_mem.pc += 1;
    }
}

fn sne(data: u16) void {
    if (chip8_mem.reg[comptime nibble(data, Nibble.second)] != (data & 0xFF)) {
        chip8_mem.pc += 1;
    }
}

//--------------------------------------------------------------//
// Emulator
//--------------------------------------------------------------//
fn decode_op_code(code: u16) void {
    // Calculate the first nibble
    // TODO use comptime function
    const first_nibble: u8 = comptime nibble(code, Nibble.first);
    const third_nibble: u8 = comptime nibble(code, Nibble.third);
    const fourth_nibble: u8 = comptime nibble(code, Nibble.fourth);

    switch (first_nibble) {
        0x0 => {
            switch (third_nibble) {
                0xE => {
                    ret();
                },
                else => {
                    cls();
                },
            }
        },
        0x1 => {
            jp_addr(code);
        },
        0x2 => {
            call(code);
        },
        0x3 => {
            se_byte(code);
        },
        0x4 => {
            sne(code);
        },
        0x5 => {},
        0x6 => {},
        0x7 => {},
        0x8 => {
            switch (third_nibble) {
                0x0 => {},
                0x1 => {},
                0x2 => {},
                0x3 => {},
                0x4 => {},
                0x5 => {},
                0x6 => {},
                0x7 => {},
                0xE => {},
            }
        },
        0x9 => {},
        0xA => {},
        0xB => {},
        0xC => {},
        0xD => {},
        0xE => {
            switch (third_nibble) {
                0x9 => {},
                0xA => {},
            }
        },
        0xF => {
            switch (third_nibble) {
                0x0 => {
                    switch (fourth_nibble) {
                        0x7 => {},
                        0xA => {},
                    }
                },
                0x1 => {
                    switch (fourth_nibble) {
                        0x5 => {},
                        0x8 => {},
                        0xE => {},
                    }
                },
                0x2 => {},
                0x3 => {},
                0x5 => {},
                0x6 => {},
                0x6 => {},
            }
        },
    }
}

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

//--------------------------------------------------------------//
// Tests
//--------------------------------------------------------------//
test "ret" {
    // test the function probably...
}
