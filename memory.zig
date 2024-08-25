//--------------------------------------------------------------//
// Imports
//--------------------------------------------------------------//
const std: type = @import("std");
const expect = std.testing.expect;

const ArrayList = std.ArrayList;
const allocator = std.heap.page_allocator;

//--------------------------------------------------------------//
// Types
//--------------------------------------------------------------//
pub const memory = struct {
    const Self = @This();

    ram: [4096]u8,
    pc: u16,
    index: u16,
    stack: ArrayList(u16),
    reg: [16]u8,

    // So this is essentially how you would create a constructor...
    pub fn init() Self {
        return Self{
            .ram = std.mem.zeros([4096]u8),
            .pc = 0x00,
            .index = 0x00,
            .stack = ArrayList(u16).init(allocator),
            .reg = std.mem.zeroes([16]u8),
        };
    }
};

//--------------------------------------------------------------//
// Tests
//--------------------------------------------------------------//
test "memory" {
    // var chip8_mem = memory.init();
}
