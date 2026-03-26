shader_type spatial;

uniform sampler2D tex : source_color;

void fragment() {
	vec3 wn = pow(abs((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz), vec3(16.0));
    vec3 dir_masks = wn / dot(wn, vec3(1.0));
    
    vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz
            * vec3(1.0, -1.0, 1.0) * 2.0;
    vec2 x_proj = world_vertex.yz;
    vec2 y_proj = world_vertex.xz;
    vec2 z_proj = world_vertex.xy;
    vec3 combined_projected_textures = mix(
        mix(
            texture(tex, x_proj).rgb,
            texture(tex, y_proj).rgb,
            dir_masks.y
        ),
        texture(tex, z_proj).rgb,
        dir_masks.z
    );
    
    ALBEDO = combined_projected_textures;
    EMISSION = combined_projected_textures;
}
