shader_type spatial;

uniform float effect_start_distance : hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float effect_stretch : hint_range(0.1, 10.0, 0.1) = 1.0;

void fragment() {
    vec3 camera_pos = CAMERA_POSITION_WORLD;
    // Here you have w = 1.0, not 0.0 -- it's a position, not a direction
    vec3 vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    vec3 to_camera = camera_pos - vertex;

    ALPHA = clamp(length(to_camera) - effect_start_distance / effect_stretch, 0.0, 1.0);
}
