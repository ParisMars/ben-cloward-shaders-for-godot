shader_type spatial;

uniform sampler2D tex_sampler : source_color;

// Note, Godot doesn't seem to have per-face UVs, as Unity and Unreal do
void fragment() {
    vec2 uv = UV;
    // Uncomment line by line
    //uv = UV * vec2(2.0);
    //uv = UV / vec2(2.0);
    //uv = UV + vec2(0.2);
    //uv = UV + vec2(TIME * 0.1);
    //uv = UV * sin(TIME);
    vec3 tex = texture(tex_sampler, uv).rgb;
    ALBEDO = tex;
}
