shader_type spatial;

uniform sampler2D screen_sampler : hint_screen_texture;
uniform float pix : hint_range(8.0, 128.0) = 32.0;

void fragment() {
    vec3 screen = texture(screen_sampler, floor(SCREEN_UV * pix) / pix).rgb;
    ALBEDO = screen;
}
