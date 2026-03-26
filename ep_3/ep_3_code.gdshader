shader_type spatial;
//render_mode blend_mix;

uniform sampler2D albedo_texture : hint_default_black;
uniform sampler2D alpha_erosion_texture : source_color;

void fragment() {
    // NOTE: Remember that alpha is opacity, not transparency
    ALPHA = texture(alpha_erosion_texture, UV).r;  // There's no alpha in this texture
    //ALPHA = texture(alpha_erosion_texture, UV).a;  // Otherwise it would be this
    ALPHA_SCISSOR_THRESHOLD = 0.7 * abs(sin(TIME));
	ALBEDO = texture(albedo_texture, UV).rgb;
}
