const lib = @import("lib/checksum.zig");
const util = @import("lib/util.zig");

pub fn main() !void {
    const m = util.Mainer(@TypeOf(lib.sha512.handler)){ .h = lib.sha512.handler };
    return m.main();
}
