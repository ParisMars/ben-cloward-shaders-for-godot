shader_type spatial;
render_mode cull_disabled;

uniform sampler2D cracks_sampler : source_color;

void fragment() {
    vec4 cracks = texture(cracks_sampler, UV * 8.0);
    ALBEDO = cracks.rgb * vec3(0.9, 0.1, 0.1);
    SPECULAR = 1.0;
    METALLIC = 1.0;
    ALPHA = cracks.a;
}
