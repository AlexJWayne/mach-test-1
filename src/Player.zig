const std = @import("std");

const assets = @import("assets");
const mach = @import("mach");
const vec2 = mach.math.vec2;
const vec3 = mach.math.vec3;
const Mat3x3 = mach.math.Mat3x3;
const Mat4x4 = mach.math.Mat4x4;

const App = @import("App.zig");

const Player = @This();

pub const mach_module = .player;

pub const mach_systems = .{
    .init,
};

player_sprite_id: mach.ObjectID = undefined,

pub fn init(
    player: *Player,
    app: *App,
    sprite: *mach.gfx.Sprite,
) !void {
    player.player_sprite_id = try sprite.objects.new(.{
        .transform = Mat4x4.translate(vec3(0, 0, 0)),
        .size = vec2(64, 64),
        .uv_transform = Mat3x3.translate(vec2(0, 0)),
    });

    try sprite.pipelines.setParent(player.player_sprite_id, app.pipeline_id);
}
