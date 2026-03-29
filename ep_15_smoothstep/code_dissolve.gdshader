shader_type spatial;

uniform sampler2D noise_texture;
uniform vec3 colour : source_color;
uniform float time_scalar : hint_range(0.0, 10.0) = 1.0;
uniform float sizzle_width : hint_range(0.01, 1.0, 0.01) = 0.01;
uniform float shield_coverage : hint_range(0.0, 1.0);
uniform bool invert_coverage = false;
uniform float sizzle_strength : hint_range(0.0, 1.0) = 0.2;
uniform float emission : hint_range(0.0, 1.0) = 0.0;

float fresnel(vec3 a, vec3 b, float power) {
    return pow(clamp(1.0 - dot(a, b), 0.0, 1.0), power);
}

void fragment() {
    float sinusoidal_time = sin(TIME * time_scalar) * 0.5 + 0.5;
    float big_mask = step(sinusoidal_time, texture(noise_texture, UV).r);
    float small_mask = step(sinusoidal_time + sizzle_width, texture(noise_texture, UV).r);
    float sizzle_mask = big_mask - small_mask;
    float shield_fresnel;
    if (invert_coverage) {
            shield_fresnel = 1.0 - fresnel(NORMAL, VIEW, (1.0 - shield_coverage) * 8.0);
    }
    else {
        shield_fresnel = fresnel(NORMAL, VIEW, (1.0 - shield_coverage) * 8.0);
    }
    float sizzle_fresnel = fresnel(NORMAL, VIEW, (1.0 - sizzle_strength) * 3.0);
    ALPHA = clamp(sizzle_mask * sizzle_fresnel + shield_fresnel, 0.0, 1.0);
    ALBEDO = colour;
    EMISSION = vec3(emission);
}
