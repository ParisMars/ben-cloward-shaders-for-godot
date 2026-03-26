shader_type spatial;

// The settings for this noise texture are in the inspector. Play around with
// them for wildly different and useful textures.
// (mesh -> material -> shader parameters -> noise texture)
uniform sampler2D noise_sampler;

void fragment() {
    vec3 noise = texture(noise_sampler, UV).rgb;
    vec3 multi_coloured_noise = vec3(
        noise.r,
        texture(noise_sampler, UV + vec2(0.3)).r,  // Just some random offsets
        texture(noise_sampler, UV - vec2(0.15, 0.8)).r
    );

    // Uncomment these lines one by one, from top to bottom, to see each
    // operation in effect.
    //ALBEDO = noise;
    //ALBEDO = noise + 0.5;
    //ALBEDO = noise - 0.5;
    //ALBEDO = noise * 0.5;
    //ALBEDO = noise / 0.5;
    //ALBEDO = multi_coloured_noise;
    //ALBEDO = multi_coloured_noise - 0.5;  // Subtracts 0.5 from each channel
    //ALBEDO = 1.0 - noise;
}
