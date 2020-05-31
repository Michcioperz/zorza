const std = @import("std");
const cat = @import("./cat.zig");
const tru = @import("./true.zig");
const fals = @import("./false.zig");

const Handler = fn (*std.mem.Allocator, *std.process.ArgIterator) anyerror!void;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var alloc = &arena.allocator;
    var args = std.process.args();
    var argv0 = try args.next(alloc).?;
    var filename = std.fs.path.basename(argv0);
    const sc = std.hash_map.eqlString;
    if (sc(filename, "cat")) {
        return cat.handler(alloc, &args);
    } else if (sc(filename, "false")) {
        return fals.handler(alloc, &args);
    } else if (sc(filename, "true")) {
        return tru.handler(alloc, &args);
    } else {
        std.debug.panic("unexpected command name: {}\n", .{filename});
    }
}
