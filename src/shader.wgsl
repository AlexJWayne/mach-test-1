@binding(0) @group(0) var<uniform> x : f32; // added

@vertex fn vertex_main(
    @builtin(vertex_index) VertexIndex : u32
) -> @builtin(position) vec4<f32> {
    var pos = array<vec2<f32>, 3>(
        vec2<f32>( 0.0,  0.5),
        vec2<f32>(-0.5, -0.5),
        vec2<f32>( 0.5, -0.8)
    );
    return vec4<f32>(
        pos[VertexIndex] + vec2<f32>(x, 0.0),
        0.0,
        1.0
    );
}

@fragment fn frag_main() -> @location(0) vec4<f32> {
    return vec4<f32>(1.0, 0.0, 0.0, 1.0);
}
