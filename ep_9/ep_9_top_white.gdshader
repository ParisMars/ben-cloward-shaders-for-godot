shader_type spatial;

void fragment() {
    // Simpler than taking the dot
	float up_alignment = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).y;
    ALBEDO = vec3(up_alignment);
}
