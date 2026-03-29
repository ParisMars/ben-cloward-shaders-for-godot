shader_type canvas_item;

// Use a Color rect to apply a screen-wide screen-reading shader

uniform sampler2D screen_sampler : hint_screen_texture;
uniform float brighten_amount : hint_range(0.0, 1.0) = 0.1;
uniform float darken_amount : hint_range(0.0, 1.0) = 0.5;
uniform float ca_offset : hint_range(0.0, 0.01) = 0.005;

uniform int filter_mode : hint_enum(
    "Brighten", "Darken", "Chromatic Aberration"
    ) = 0;

vec3 brighten(vec3 colour, float brighten_amnt) {
    return min(colour + vec3(brighten_amnt), vec3(1.0));
}

vec3 darken(vec3 colour, float darken_amnt) {
    //return max(colour - vec3(darken_amnt), vec3(0.0));  // Subtract
    return colour * vec3(darken_amnt);  // Multiply
}

vec3 chromatic_aberration(vec2 st, float offset) {
    float r = texture(screen_sampler, st).r;
    float g = texture(screen_sampler, st - offset).g;
    float b = texture(screen_sampler, st + offset).b;
    return vec3(r, g, b);
}

void fragment() {
    vec4 screen = texture(screen_sampler, SCREEN_UV);
    switch (filter_mode) {
        case 0:
            COLOR.rgb = brighten(screen.rgb, brighten_amount);
            break;
        case 1:
            COLOR.rgb = darken(screen.rgb, darken_amount);
            break;
        case 2:
            COLOR.rgb = chromatic_aberration(SCREEN_UV, ca_offset);
            break;
    }
}
