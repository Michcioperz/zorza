const lib = @import("lib/checksum.zig");
const util = @import("lib/util.zig");

pub fn main() !void {
    const m = util.Mainer(@TypeOf(lib.md5.handler)){ .h = lib.md5.handler };
    return m.main();
}
