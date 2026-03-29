shader_type spatial;

uniform sampler2D nm_sampler : hint_normal;

float overlay(float a, float b) {
    return (a < 0.5) ? 2.0 * a * b : 1.0 - 2.0 * (1.0 - a) * (1.0 - b);
}

void fragment() {
    vec2 base_normal_map = texture(nm_sampler, UV).rg;
    vec2 detail_normal_map = texture(nm_sampler, UV * 4.0).rg;
    vec2 blended_normal_map = vec2(
            overlay(base_normal_map.r, detail_normal_map.r),
            overlay(base_normal_map.g, detail_normal_map.g)
    );

    NORMAL_MAP = vec3(blended_normal_map, 0.0);
    ALBEDO = vec3(0.1);
    ROUGHNESS = 0.5;
}
