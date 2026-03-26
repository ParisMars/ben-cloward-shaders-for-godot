shader_type spatial;

uniform sampler2D triplanar_tex : source_color;

void fragment() {
    vec3 direction_masks = pow(abs((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz), vec3(64.0));
    direction_masks = round(direction_masks / dot(direction_masks, vec3(1.0)));

    vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz
            * vec3(1.0, -1.0, 1.0) * 2.0;
    vec2 x_projection = world_vertex.yz;
    vec2 y_projection = world_vertex.xz;
    vec2 z_projection = world_vertex.xy;
    vec2 combined_projections = mix(
        mix(
            x_projection,
            y_projection,
            direction_masks.y
        ),
        z_projection,
        direction_masks.z
    );
    
    vec3 projected_texture = texture(triplanar_tex, combined_projections).rgb;
    ALBEDO = projected_texture;
    EMISSION = projected_texture;
}
