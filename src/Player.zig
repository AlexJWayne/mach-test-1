const std = @import("std");

const assets = @import("assets");
const mach = @import("mach");
const vec2 = mach.math.vec2;
const vec3 = mach.math.vec3;
const Mat3x3 = mach.math.Mat3x3;
const Mat4x4 = mach.math.Mat4x4;
const Vec2 = mach.math.Vec2;

const App = @import("App.zig");

const Player = @This();

pub const mach_module = .player;

pub const mach_systems = .{
    .init,
    .updatePlayer,
};

direction: Vec2 = vec2(0, 0),
spawning: bool = false,

sprite_id: mach.ObjectID = undefined,

pub fn init(
    player: *Player,
    app: *App,
    sprite: *mach.gfx.Sprite,
) !void {
    player.sprite_id = try sprite.objects.new(.{
        .transform = Mat4x4.translate(vec3(0, 0, 0)),
        .size = vec2(64, 64),
        .uv_transform = Mat3x3.translate(vec2(0, 0)),
    });

    try sprite.pipelines.setParent(player.sprite_id, app.pipeline_id);
}

pub fn updatePlayer(
    app: *App,
    player: *Player,
    sprite: *mach.gfx.Sprite,
) !void {
    const delta_time = app.delta_time;
    var direction = player.direction;

    var player_sprite = sprite.objects.getValue(player.sprite_id);
    var player_pos = player_sprite.transform.translation();

    // Calculate the player position, by moving in the direction the player wants to go
    // by the speed amount.
    const speed = 200.0;
    player_pos.v[0] += direction.x() * speed * delta_time;
    player_pos.v[1] += direction.y() * speed * delta_time;
    sprite.objects.set(player.sprite_id, .transform, Mat4x4.translate(player_pos));
}
