shader_type spatial;

uniform sampler2D godot_icon;

void vertex() {
	UV.x += 0.3 * sin(3.0 * TIME);  // Cheaper to do this in the vertex shader
	//VERTEX.y += 0.1 * sin(3.0 * TIME);
}

void fragment() {
	vec4 tex = texture(godot_icon, UV);
    ALBEDO = tex.rgb;
}
