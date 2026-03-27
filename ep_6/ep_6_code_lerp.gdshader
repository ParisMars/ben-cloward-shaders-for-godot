shader_type spatial;

/* Comment stuff out to isolate the blend you want */

// Find these in the inspector under 'Shader Parameters'
uniform float weight : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D texture_1_sampler : source_color;
uniform sampler2D texture_2_sampler : source_color;

void fragment() {
    // Manual lerp
    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    ALBEDO = red * weight + blue * (1.0 - weight);
    
    // Built-in lerp
    ALBEDO = mix(blue, red, weight);
    
    // Texture lerp
    vec3 texture_1 = texture(texture_1_sampler, UV).rgb;
    vec3 texture_2 = texture(texture_2_sampler, UV).rgb;
    ALBEDO = mix(texture_1, texture_2, weight);
}
