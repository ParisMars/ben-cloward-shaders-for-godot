shader_type spatial;
render_mode unshaded;

float fresnel(vec3 a, vec3 b) {
    return clamp(1.0 - dot(a, b), 0.0, 1.0);
}

void fragment() {
    /**
    Both are the same, except in the first line both the NORMAL and VIEW
    are being transformed from view space to world space. Refer to
    to see what VIEW, NORMAL, and whatever else are. The Godot shader reference
    is actually very clear.
    
    The vec4(yada, 1.0) is just so I can actually multiply the matrix by the
    thing. On a side note, I don't understand matrix-vector multiplication order
    in shaders. What does it even mean to have vec * mat?
    
    Anytime you're doing anything with multiple vectors, make sure they are
    in the same space. Also, make sure that they're normalised when they
    need to be.
    */
	//ALBEDO = vec3(fresnel((vec4(NORMAL, 1.0) * INV_VIEW_MATRIX).xyz, (vec4(VIEW, 1.0) * INV_VIEW_MATRIX).xyz));
	ALBEDO = vec3(fresnel(NORMAL, VIEW));
}
