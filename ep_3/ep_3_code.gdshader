shader_type spatial;

// Uncomment this and the line at the bottom if you want the colour to be
// exposed in the inspector. Look for the 'Shader Parameters' section.
uniform vec3 colour : source_color = vec3(0.7, 0.2, 0.3);

void fragment() {
    // The three values correspond to red, green, and blue, ranging from 0 to 1
    ALBEDO = vec3(0.1, 0.1, 0.8);

    //ALBEDO = colour;
}
