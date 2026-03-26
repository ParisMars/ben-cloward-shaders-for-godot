shader_type sky;

uniform samplerCube sky_cubemap : source_color;

void sky() {
    vec3 sky_texture = texture(sky_cubemap, EYEDIR).rgb;
    COLOR = sky_texture;
}
