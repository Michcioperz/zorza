const std = @import("std");

pub fn handler(_alloc: *std.mem.Allocator, _args: *std.process.ArgIterator) !void {
    std.process.exit(0);
}
