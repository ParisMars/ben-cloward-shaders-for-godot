shader_type spatial;

uniform sampler2D noise_sampler;

vec3 create_mask_selection_texture(sampler2D s, vec2 uv) {
    float noise_r = texture(s, uv * 8.0).r;
    float noise_g = texture(s, uv * 4.0).r;
    float noise_b = texture(s, uv).r;
    return floor(vec3(noise_r, noise_g, noise_b) * 2.0) / 2.0;
}

void fragment() {
    // Manual dot
    vec3 A = vec3(1.0);
    vec3 B = vec3(0.5);
    float result = (A.x * B.x) + (A.y * B.y) + (A.z * B.z);
    
    // Built-in dot
    result = dot(A, B);

    // For desaturation example, see previous ep. folder
    
    // Mask selection
    vec3 masks = create_mask_selection_texture(noise_sampler, UV);
    float selected_mask = dot(masks, vec3(0.0, 1.0, 0.0));
    ALBEDO = vec3(selected_mask);
    
    // Simple Fresnel
    ALBEDO = vec3(1.0 - dot(VIEW, NORMAL));
}
