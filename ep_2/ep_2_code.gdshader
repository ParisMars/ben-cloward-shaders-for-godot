shader_type spatial;

// If you don't add the source colour hint, the texture will be interpreted
// as data and will appear washed out.
uniform sampler2D texture_parameter : source_color;

void vertex() {
    // Bounce
    VERTEX.y += abs(sin(3.0 * TIME)) + 0.5;
    
    // Rotate (vertex shader version)
    UV.x += 0.5 * sin(TIME * 0.5) + 0.5;
}

void fragment() {
    vec2 uv_offset = vec2(0.0);
    // Rotate (frag shader version)
    //uv_offset = vec2(0.5 * sin(TIME * 0.5) + 0.5, 0.0);
    
    ALBEDO = texture(texture_parameter, UV + uv_offset).rgb;
}
