const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    b.setPreferredReleaseMode(.ReleaseSmall);
    const mode = b.standardReleaseOptions();
    const bloat = b.option(bool, "bloat", "be additionally snarky about every single unnecessary kilobyte") orelse false;

    inline for (.{
        "src/zorza.zig",
        "src/cat.zig",
        "src/md5sum.zig",
        "src/sha1sum.zig",
        "src/sha224sum.zig",
        "src/sha256sum.zig",
        "src/sha384sum.zig",
        "src/sha512sum.zig",
        "src/true.zig",
        "src/false.zig",
    }) |filename| {
        comptime var nameSplit = std.mem.split(std.fs.path.basename(filename), ".");
        comptime var name = nameSplit.next().?;
        const exe = b.addExecutable(name, filename);
        if (bloat) {
            exe.single_threaded = true;
            exe.strip = true;
        }
        exe.setTarget(target);
        exe.setBuildMode(mode);
        exe.install();
    }
}
