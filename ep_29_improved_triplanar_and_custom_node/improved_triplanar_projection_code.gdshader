shader_type spatial;

uniform sampler2D tp_texture : source_color;
uniform float sharpness : hint_range(1.0, 64.0, 1.0) = 8.0;
uniform float tiling_fac : hint_range(0.1, 8.0, 0.1) = 1.0;

void fragment() {
    vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
    vec3 adjusted_normals = pow(abs(world_normal), vec3(sharpness));
    vec3 dir_masks = adjusted_normals / dot(adjusted_normals, vec3(1.0));
    vec3 sign_stuff = sign(world_normal) * vec3(-1.0, 1.0, 1.0);

    vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz
            * vec3(1.0, -1.0, 1.0) * tiling_fac;
    vec2 x_proj = world_vertex.zy * vec2(sign_stuff.x, 1.0);  // Swap yz, else projection is sideways
    vec2 y_proj = world_vertex.xz * vec2(sign_stuff.y, 1.0);
    vec2 z_proj = world_vertex.xy * vec2(sign_stuff.z, 1.0);
    vec3 combined_projected_textures = mix(
        mix(
            texture(tp_texture, x_proj).rgb,
            texture(tp_texture, y_proj).rgb,
            dir_masks.y
        ),
        texture(tp_texture, z_proj).rgb,
        dir_masks.z
    );

    ALBEDO = combined_projected_textures;
    EMISSION = combined_projected_textures;
}
