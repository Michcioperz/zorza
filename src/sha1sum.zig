const lib = @import("lib/checksum.zig");
const util = @import("lib/util.zig");

pub fn main() !void {
    const m = util.Mainer(@TypeOf(lib.sha1.handler)){ .h = lib.sha1.handler };
    return m.main();
}
