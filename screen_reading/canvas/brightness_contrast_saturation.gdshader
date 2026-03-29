shader_type canvas_item;

uniform sampler2D screen_sampler : hint_screen_texture;
uniform float amount : hint_range(-1.0, 2.0) = 1.0;

void fragment() {
    vec3 screen = texture(screen_sampler, SCREEN_UV).rgb;
    
    vec3 brightness = mix(vec3(0.0), screen, amount);
    vec3 contrast = mix(vec3(0.5), screen, amount);
    
    vec3 luminance_weights = vec3(0.22, 0.72, 0.06);
    vec3 desaturated_screen = vec3(dot(screen, luminance_weights));
    vec3 saturation = mix(desaturated_screen, screen, amount);
    
    COLOR.rgb = brightness;
    COLOR.rgb = contrast;
    COLOR.rgb = saturation;
}
