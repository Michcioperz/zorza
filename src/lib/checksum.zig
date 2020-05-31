const std = @import("std");

const PAGE_SIZE = 4096;

fn summer(comptime specAlgo: var) type {
    const T = @TypeOf(specAlgo);
    return struct {
        algo: T,
        const Self = @This();
        pub fn handler(comptime self: Self, alloc: *std.mem.Allocator, pathIter: *std.process.ArgIterator) !void {
            const algo = self.algo;
            var cout = std.io.getStdOut().outStream();
            var cwd = std.fs.cwd();
            var buf: [PAGE_SIZE]u8 = undefined;
            while (pathIter.next(alloc)) |pathOrErr| {
                var path = try pathOrErr;
                defer alloc.free(path);
                var file = try cwd.openFile(path, std.fs.File.OpenFlags{
                    .read = true,
                    .write = false,
                    .lock = .None,
                    .lock_nonblocking = false,
                });
                defer file.close();
                var hash = algo.init();
                var n: usize = 1;
                while (n > 0) {
                    n = try file.read(buf[0..PAGE_SIZE]);
                    if (n > 0) {
                        hash.update(buf[0..n]);
                    }
                }
                var sum: [algo.digest_length]u8 = undefined;
                hash.final(sum[0..algo.digest_length]);
                try cout.print("{x} {}\n", .{ sum, path });
            }
        }
        pub fn init() Self {
            return Self{ .algo = specAlgo };
        }
    };
}

pub const md5 = summer(std.crypto.Md5).init();
pub const sha1 = summer(std.crypto.Sha1).init();
pub const sha224 = summer(std.crypto.Sha224).init();
pub const sha256 = summer(std.crypto.Sha256).init();
pub const sha384 = summer(std.crypto.Sha384).init();
pub const sha512 = summer(std.crypto.Sha512).init();
