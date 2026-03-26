shader_type spatial;

// Literally anytime there's a division, consider if there could
// ever be a division by zero error
uniform sampler2D noise_sampler : source_color;
uniform sampler2D pattern_sampler : source_color;

uniform vec3 colour : source_color = vec3(1.0);
uniform float shield_coverage : hint_range(0.1, 5.0, 0.1) = 1.0;
uniform float shield_intensity : hint_range(0.0, 10.0, 0.1) = 1.0;

float fresnel(vec3 a, vec3 b, float power) {
    return pow(clamp(1.0 - dot(a, b), 0.0, 1.0), power);
}

void fragment() {
    vec2 uv = UV;
    uv += texture(noise_sampler, UV).r * 0.03;
    uv += TIME * 0.1;
    ALBEDO = colour + 20.0 * texture(pattern_sampler, uv * 8.0).rgb;
    //ALPHA = fresnel(NORMAL, VIEW, 1.0 / shield_coverage);
    ALPHA = clamp(fresnel(NORMAL, VIEW, 1.0 / shield_coverage) * (texture(noise_sampler, UV + vec2(TIME * 0.1, 0.0)).r + texture(noise_sampler, UV - vec2(TIME * 0.03)).r) * abs(0.3 * (sin(TIME) + 1.7)), 0.0, 1.0);
    EMISSION = shield_intensity * colour;
    //ALPHA_SCISSOR_THRESHOLD = abs(sin(TIME));
}
