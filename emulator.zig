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

    memory: mem,

    pub fn init() Self {
        return Self{.memory.init()};
    }

    pub fn ret() void {
        .memory.pc = .memory.stack.pop();
    }

    pub fn cls() void {
        // TODO need screen impl
    }

    pub fn jp_addr(data: u16) void {
        .memory.pc = data & 0x0FFF;
    }

    pub fn call(data: u16) void {
        .memory.stack.append(.memory.pc);
        .memory.pc = data & 0x0FFF;
    }

    pub fn se_byte(data: u16) void {
        if (.memory.reg[comptime nibble(data, Nibble.second)] == (data & 0xFF)) {
            .memory.pc += 1;
        }
    }

    pub fn sne(data: u16) void {
        if (.memory.reg[comptime nibble(data, Nibble.second)] != (data & 0xFF)) {
            .memory.pc += 1;
        }
    }

    pub fn se_reg(data: u16) void {
        if (.memory.reg[comptime nibble(data, 2)] == .memory.reg[comptime nibble(data, 3)]) {
            .memory.pc += 1;
        }
    }
};

// TODO make me work
// test "emulator" {
//     var emu: emulator = emulator{.memory = .{.}};
//     emu.init();

//     emu.jp_addr(0xAAAA);
//     try expect(emu.memory.pc == 0x0AAA);
//     emu.init();
// }
