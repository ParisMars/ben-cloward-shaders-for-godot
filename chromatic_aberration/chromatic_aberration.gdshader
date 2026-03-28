shader_type canvas_item;

uniform float channel_uv_offset : hint_range(0.0, 1.0) = 0.1;
uniform sampler2D noise_sampler;
uniform sampler2D tex_sampler : source_color;

void fragment() {
    float no = texture(noise_sampler, UV).r * 0.1;
    float red = texture(tex_sampler, UV).r;
    float green = texture(tex_sampler, UV - no * channel_uv_offset).g;
    float blue = texture(tex_sampler, UV + no * channel_uv_offset).b;
    //float red = texture(tex_sampler, UV).r;
    //float green = texture(tex_sampler, UV - channel_uv_offset).g;
    //float blue = texture(tex_sampler, UV + channel_uv_offset).b;
    COLOR = vec4(red, green, blue, 1.0);
}
