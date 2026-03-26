shader_type spatial;
//render_mode unshaded;

// The source colour hint is what's avoiding the washed out look
// In the visual shader, set the texture parameter to colour, not data
// achieve the same effect 
uniform sampler2D tex : source_color;
//uniform sampler2D tex;

void fragment() {
    vec2 uv = UV;
    uv *= 4.0;
    uv.x += fract(TIME * 0.4);
    ALBEDO = texture(tex, uv).rgb;
}
