shader_type spatial;

uniform sampler2D noise_sampler;

void fragment() {
    vec2 offset = vec2(TIME) * 0.1;
    ALBEDO = texture(noise_sampler, UV + offset).rgb;
}
