const lib = @import("lib/true.zig");
const util = @import("lib/util.zig");

pub fn main() !void {
    const m = util.Mainer(@TypeOf(lib.handler)){ .h = lib.handler };
    return m.main();
}
