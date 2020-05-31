const std = @import("std");
const cat = @import("lib/cat.zig");
const tru = @import("lib/true.zig");
const fals = @import("lib/false.zig");
const sum = @import("lib/checksum.zig");

fn handler(alloc: *std.mem.Allocator, args: *std.process.ArgIterator) !void {
    var argv0 = try args.next(alloc).?;
    var filename = std.fs.path.basename(argv0);
    const sc = std.hash_map.eqlString;
    switch (filename[0]) {
        'c' => {
            if (sc(filename, "cat"))
                return cat.handler(alloc, args);
        },
        'f' => {
            if (sc(filename, "false"))
                return fals.handler(alloc, args);
        },
        'm' => {
            if (sc(filename, "md5sum"))
                return sum.md5.handler(alloc, args);
        },
        's' => {
            switch (filename[1]) {
                'h' => {
                    switch (filename[2]) {
                        'a' => {
                            switch (filename[3]) {
                                '1' => {
                                    if (sc(filename, "sha1sum"))
                                        return sum.sha1.handler(alloc, args);
                                },
                                '2' => {
                                    switch (filename[4]) {
                                        '2' => {
                                            if (sc(filename, "sha224sum"))
                                                return sum.sha224.handler(alloc, args);
                                        },
                                        '5' => {
                                            if (sc(filename, "sha256sum"))
                                                return sum.sha256.handler(alloc, args);
                                        },
                                        else => {},
                                    }
                                },
                                '3' => {
                                    if (sc(filename, "sha384sum"))
                                        return sum.sha384.handler(alloc, args);
                                },
                                '5' => {
                                    if (sc(filename, "sha512sum"))
                                        return sum.sha512.handler(alloc, args);
                                },
                                else => {},
                            }
                        },
                        else => {},
                    }
                },
                else => {},
            }
        },
        't' => {
            if (sc(filename, "true"))
                return tru.handler(alloc, args);
        },
        'z' => {
            if (sc(filename, "zorza"))
                return handler(alloc, args);
        },
        else => {},
    }
    std.debug.panic("unexpected command name: {}\n", .{filename});
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var alloc = &arena.allocator;
    var args = std.process.args();
    return handler(alloc, &args);
}
