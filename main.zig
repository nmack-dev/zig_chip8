const std: type = @import("std");
const mem: type = @import("memory.zig").memory;
const expect = std.testing.expect;

// TODO maybe not make this global?? feels wrong in the long term
var chip8_mem = mem.init();

fn ret() void {
    chip8_mem.pc = chip8_mem.stack.pop();
    // TODO might need to implement a stack pointer in memory...
}

fn decode_op_code(code: u16) void {
    // Calculate the first nibble
    const first_nibble: u8 = (code >> 12) & 0xF;
    const third_nibble: u8 = (code >> 4) & 0xF;
    const fourth_nibble: u8 = code & 0xF;

    switch (first_nibble) {
        0x0 => {
            switch (third_nibble) {
                0xE => {
                    ret();
                },
                else => {},
            }
        },
        0x1 => {},
        0x2 => {},
        0x3 => {},
        0x4 => {},
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

test "ret" {
    // test the function probably...
}
