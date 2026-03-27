shader_type spatial;

// Anytime you want to make a custom node, make sure the code version works
// exactly like this.

uniform sampler2D noise_sampler;

vec3 create_three_channel_noise(vec2 st, sampler2D ns) {
    float noise_r = texture(ns, st).r;
    float noise_g = texture(ns, st + vec2(0.27, 0.85)).r;
    float noise_b = texture(ns, st - vec2(0.47, -0.31)).r;
    return vec3(noise_r, noise_g, noise_b);
}

void fragment() {
    ALBEDO = create_three_channel_noise(UV, noise_sampler);
}
