//--------------------------------------------------------------//
// Imports
//--------------------------------------------------------------//
const std: type = @import("std");
const mem: type = @import("memory.zig").memory;
const nibble = @import("nibble_utl.zig").nibble;
const Nibble = @import("nibble_utl.zig").Nibble;
const emulator = @import("emulator.zig").emulator;
const expect = std.testing.expect;

//--------------------------------------------------------------//
// Parse op codes
//--------------------------------------------------------------//
fn decode_op_code(emu: *emulator, code: u16) void {
    // Calculate the first nibble
    // TODO use comptime function
    const first_nibble: u8 = comptime nibble(code, Nibble.first);
    const third_nibble: u8 = comptime nibble(code, Nibble.third);
    const fourth_nibble: u8 = comptime nibble(code, Nibble.fourth);

    switch (first_nibble) {
        0x0 => {
            switch (third_nibble) {
                0xE => {
                    emu.ret();
                },
                else => {
                    emu.cls();
                },
            }
        },
        0x1 => {
            emu.jp_addr(code);
        },
        0x2 => {
            emu.call(code);
        },
        0x3 => {
            emu.se_byte(code);
        },
        0x4 => {
            emu.sne(code);
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
// test "instruction set" {
//     try expect(ok: bool)
// }
