const std = @import("std");

const mach = @import("mach");

// The global list of Mach modules registered for use in our application.
pub const Modules = mach.Modules(.{
    mach.Core,
    mach.gfx.Sprite,
    @import("App.zig"),
    @import("Player.zig"),
});

pub fn main() !void {
    const allocator = std.heap.c_allocator;

    // The set of Mach modules our application may use.
    var mods: Modules = undefined;
    try mods.init(allocator);
    // TODO: enable mods.deinit(allocator); for allocator leak detection
    // defer mods.deinit(allocator);

    const app = mods.get(.app);
    app.run(.main);
}
