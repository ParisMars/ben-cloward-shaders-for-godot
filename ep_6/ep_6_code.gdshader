shader_type spatial;

//uniform float mix_amount : hint_range(0.0, 1.0, 0.1) = 0.0;
uniform float time_scalar : hint_range(0.2, 5.0, 0.2) = 1.0;

float ping_pong(float t) {
    return 1.0 - abs(mod(t, 2.0) - 1.0);
}

void fragment() {
vec3 blue = vec3(0.0, 0.0, 1.0);
vec3 red = vec3(1.0, 0.0, 0.0);

ALBEDO = mix(blue, red, ping_pong(TIME * time_scalar));
}
