const lib = @import("lib/checksum.zig");
const util = @import("lib/util.zig");

pub fn main() !void {
    const m = util.Mainer(@TypeOf(lib.sha256.handler)){ .h = lib.sha256.handler };
    return m.main();
}
