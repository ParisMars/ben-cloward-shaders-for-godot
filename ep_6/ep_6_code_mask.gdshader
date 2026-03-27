shader_type spatial;

uniform sampler2D tex_1_sampler : source_color;
uniform sampler2D tex_2_sampler : source_color;
uniform sampler2D mask_sampler;

void fragment() {
    vec3 tex_1 = texture(tex_1_sampler, UV).rgb;
    vec3 tex_2 = texture(tex_2_sampler, UV).rgb;
    float mask = texture(mask_sampler, UV).r;
    ALBEDO = mix(tex_1, tex_2, mask);
}
