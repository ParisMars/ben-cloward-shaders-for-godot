shader_type spatial;

uniform sampler2D tex : source_color;

void fragment() {
    vec3 up = vec3(0.0, 1.0, 0.0);
    // Here I'm also applying an inverse model-to-world transform so that
    // the texture sticks to the top of the thing on rotation (like moss
    // on moving rocks).
    vec3 n = (inverse(MODEL_MATRIX) * INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
    float ndotu = dot(up, n);

    ALBEDO = texture(tex, UV * 4.0).rgb * clamp(ndotu, 0.0, 1.0);
}
