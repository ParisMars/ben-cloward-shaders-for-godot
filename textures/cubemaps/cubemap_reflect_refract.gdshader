shader_type spatial;

// Anytime you do something and it looks like UV colours, maybe you're supposed
// to use it as UVs

uniform sampler2D noise_tex;
uniform samplerCube cubemap : source_color;
uniform float power : hint_range(0.0, 8.0) = 2.0;
uniform float eta : hint_range(0.0, 3.0) = 1.35;
uniform float time_scalar : hint_range(0.0, 2.0) = 0.5;
uniform float half_delta : hint_range(0.0, 1.0, 0.01) = 0.01;

float fresnel(vec3 norm, vec3 view, float exponent) {
    return pow(1.0 - clamp(dot(norm, view), 0.0, 1.0), exponent);
}

void fragment() {
    vec3 cam_dir = CAMERA_DIRECTION_WORLD;
    vec3 N = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
    
    vec3 reflection = reflect(-1.0 * cam_dir, N);
    vec3 refraction = refract(cam_dir, N, eta);
    vec3 reflection_tex = texture(cubemap, reflection).rgb;
    vec3 refraction_tex = texture(cubemap, refraction).rgb;

    float mask = fresnel(NORMAL, VIEW, power);
    vec3 reflection_and_refraction = mix(refraction_tex, reflection_tex, mask);
    
    float edge = sin(TIME * time_scalar) * 0.5 + 0.5;
    ALPHA = smoothstep(edge - half_delta, edge + half_delta, texture(noise_tex, UV).r);
    EMISSION = reflection_and_refraction;
    ALBEDO = reflection_and_refraction;
}
