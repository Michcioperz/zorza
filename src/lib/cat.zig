const std = @import("std");

const PAGE_SIZE = 4096;

pub fn handler(alloc: *std.mem.Allocator, pathIter: *std.process.ArgIterator) !void {
    var bufArr: [PAGE_SIZE]u8 = undefined;
    var buf = bufArr[0..PAGE_SIZE];
    var cwd = std.fs.cwd();
    var out = std.io.getStdOut();
    while (pathIter.next(alloc)) |pathOrErr| {
        var path = try pathOrErr;
        defer alloc.free(path);
        var file = if (std.hash_map.eqlString(path, "-"))
            std.io.getStdIn()
        else
            try cwd.openFile(path, .{
                .read = true,
                .write = false,
            });
        defer file.close();
        var n: ?usize = null;
        while (n orelse 1 > 0) {
            n = try file.read(buf);
            try out.writeAll(buf[0 .. n orelse 0]);
        }
    }
}
