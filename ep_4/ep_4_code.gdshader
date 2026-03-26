shader_type spatial;

uniform sampler2D noise_texture : source_color;
uniform sampler2D distortion_texture : source_color;
uniform float distortion_intensity : hint_range(0.0, 0.1, 0.01) = 0.03;
uniform float layer_1_scroll_speed : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float layer_2_scroll_speed : hint_range(0.0, 1.0, 0.01) = 0.07;

void fragment() {
    vec2 base_uv = UV;
    // Adds to both channels, so can just have ).r instead of ).rr (See note below)
    base_uv += texture(distortion_texture, UV).r * distortion_intensity;
    vec2 uv = base_uv;
    vec2 uv_2 = base_uv;
    
    uv += TIME * layer_1_scroll_speed;  // Time is added to both channels, not just x
    uv_2.x -= TIME * layer_2_scroll_speed;
    
    vec3 noise_layer_1 = texture(noise_texture, uv).rgb;
    vec3 noise_layer_2 = texture(noise_texture, uv_2).rgb;
    vec3 noise_layers = mix(noise_layer_1, noise_layer_2, 0.4); 

    ALBEDO = vec3(0.8, 0.3, 0.2) * noise_layers;
}
