shader_type spatial;

uniform sampler2D voronoi_noise;

void fragment() {
    // Min, max, clamp (code shaders have no saturate)
    float tex = texture(voronoi_noise, UV).r;
    float mask = min(tex, 0.5);
    mask = max(tex, 0.5);
    mask = clamp(tex, 0.2, 0.8);
    ALBEDO = vec3(mask);
    
    // Blending colours and clamping the blend weight
    vec3 colour_a = vec3(0.1, 0.1, 1.0);
    vec3 colour_b = vec3(1.0, 0.1, 0.1);
    vec3 N = normalize(INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
    ALBEDO = clamp(mix(colour_b, colour_a, N.y), 0.0, 1.0);
}
