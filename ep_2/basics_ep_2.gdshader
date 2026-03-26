shader_type spatial;

uniform float quantise_amount = 32.0;
uniform sampler2D tex;

vec2 quantise(vec2 st, float amount) {
    return floor(st * amount) / amount;
}

void vertex() {
	VERTEX.y += abs(0.5 * sin(TIME * 2.0));
}

void fragment() {
    vec2 uv = quantise(UV, quantise_amount);
    uv.x += 0.5 * sin(TIME) + 0.5;
    ALBEDO = texture(tex, uv).rgb;
}
