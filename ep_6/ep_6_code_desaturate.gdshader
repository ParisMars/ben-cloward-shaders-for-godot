shader_type spatial;

uniform float blend_weight = 0.0;
uniform sampler2D tex_sampler : source_color;

void fragment() {
    vec3 tex = texture(tex_sampler, UV).rgb;
    vec3 luminance_weights = vec3(0.22, 0.72, 0.06);
    vec3 desaturated = vec3(dot(tex, luminance_weights));
    ALBEDO = mix(tex, desaturated, blend_weight);
}
