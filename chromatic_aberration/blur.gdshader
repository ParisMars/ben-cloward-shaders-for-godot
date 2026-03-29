shader_type canvas_item;

uniform float intensity : hint_range(0.0, 1.0) = 0.1;
uniform sampler2D screen_sampler : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise_sampler;

vec3 blur_and_chromatic_aberration(
        sampler2D sampler, vec2 st, float max_offset, float max_blur) {

    float r = textureLod(
            sampler, st, intensity * max_blur).r;
    float g = textureLod(
            sampler, st - intensity * max_offset, intensity * max_blur).g;
    float b = textureLod(
            sampler, st + intensity * max_offset, intensity * max_blur).b;
    
    return vec3(r, g, b);
}

void fragment() {
    // Regular blur
    //COLOR = textureLod(screen_sampler, SCREEN_UV, intensity * 10.0);
    
    COLOR.rgb = blur_and_chromatic_aberration(
            screen_sampler, SCREEN_UV, 0.3, 10.0);
}
