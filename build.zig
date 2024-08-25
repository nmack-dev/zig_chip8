const std: type = @import("std");
const raylib = @import("raylib/build.zig");

pub fn build(b: *std.Build) !void {
    const target = .{ .os_tag = .windows };
    const mode = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig_chip8",
        .root_source_file = b.path("main.zig"), // TODO: hello darkness my old friend
        .target = b.host,
        .optimize = mode,
    });

    raylib.addTo(b, exe, target, mode, .{});

    // b.default_step.dependOn(&exe.step);
    // b.installArtifact(exe);
}
