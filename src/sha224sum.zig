const lib = @import("lib/checksum.zig");
const util = @import("lib/util.zig");

pub fn main() !void {
    const m = util.Mainer(@TypeOf(lib.sha224.handler)){ .h = lib.sha224.handler };
    return m.main();
}
