const std = @import("std");

const Handler = fn (*std.mem.Allocator, *std.process.ArgIterator) anyerror!void;

pub fn Mainer(comptime T: type) type {
    return struct {
        h: T,
        pub fn main(comptime self: @This()) !void {
            var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
            defer arena.deinit();
            var alloc = &arena.allocator;
            var args = std.process.args();
            var _whatever = try args.next(alloc).?;
            return self.h(alloc, &args);
        }
    };
}
