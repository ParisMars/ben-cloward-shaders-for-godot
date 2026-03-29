shader_type spatial;

uniform sampler2D screen_sampler : hint_screen_texture;
uniform float offset : hint_range(0.0, 0.05) = 0.01;

void fragment() {
    float r = texture(screen_sampler, SCREEN_UV).r;
    float g = texture(screen_sampler, SCREEN_UV - offset).g;
    float b = texture(screen_sampler, SCREEN_UV + offset).b;
    ALBEDO = vec3(r, g, b);
}
