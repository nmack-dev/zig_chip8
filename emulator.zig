//--------------------------------------------------------------//
// Imports
//--------------------------------------------------------------//
const std: type = @import("std");
const mem: type = @import("memory.zig").memory;
const nibble = @import("nibble_utl.zig").nibble;
const Nibble = @import("nibble_utl.zig").Nibble;
const expect = std.testing.expect;

//--------------------------------------------------------------//
// Emulation functions
//--------------------------------------------------------------//
pub const emulator = struct {
    const Self = @This();

    chip8_mem: mem,

    pub fn init() Self {
        return Self{.chip8_mem.init()};
    }

    pub fn ret() void {
        .chip8_mem.pc = .chip8_mem.stack.pop();
    }

    pub fn cls() void {
        // TODO need screen impl
    }

    pub fn jp_addr(data: u16) void {
        .chip8_mem.pc = data & 0x0FFF;
    }

    pub fn call(data: u16) void {
        .chip8_mem.stack.append(.chip8_mem.pc);
        .chip8_mem.pc = data & 0x0FFF;
    }

    pub fn se_byte(data: u16) void {
        if (.chip8_mem.reg[comptime nibble(data, Nibble.second)] == (data & 0xFF)) {
            .chip8_mem.pc += 1;
        }
    }

    pub fn sne(data: u16) void {
        if (.chip8_mem.reg[comptime nibble(data, Nibble.second)] != (data & 0xFF)) {
            .chip8_mem.pc += 1;
        }
    }

    pub fn se_reg(data: u16) void {
        if (.chip8_mem.reg[comptime nibble(data, 2)] == .chip8_mem.reg[comptime nibble(data, 3)]) {
            .chip8_mem.pc += 1;
        }
    }
};
