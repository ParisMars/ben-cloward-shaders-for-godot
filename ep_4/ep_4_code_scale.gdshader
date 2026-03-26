shader_type spatial;

uniform sampler2D texture_sampler : source_color;

void fragment() {
    // The reason you have to add the .rgb at the end of the texture read
    // is because 'texture' returns a vector4 (rgba), representing red, green,
    // blue, and alpha channels. Albedo only wants the vector3 (rgb)
    ALBEDO = texture(texture_sampler, UV * 6.0).rgb / 4.0;
}
