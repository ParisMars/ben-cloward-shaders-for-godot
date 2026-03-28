shader_type spatial;
uniform sampler2D matcap_sampler : source_color;

uniform sampler2D moss_diff_sampler : source_color;
uniform sampler2D moss_nor_sampler : hint_normal;
uniform sampler2D rock_diff_sampler : source_color;
uniform sampler2D rock_nor_sampler : hint_normal;

uniform float sharpness : hint_range(0.0, 50.0) = 5.0;

void fragment() {
    //Matcap shader
    vec2 matcap_uv = (NORMAL * vec3(0.5, -0.5, 0.5) + 0.5).xy;
    vec3 matcap = texture(matcap_sampler, matcap_uv).rgb;
    ALBEDO = matcap;
    
    // TODO: Rotating the sphere breaks this, I don't know if it's because
    // the normal maps are no longer in tangent space or if I'm constructing
    // the TBN incorrectly. And this matrix is fucking weird; I should be
    // able to just cross normal and tan and get the bitan, but that gives weird
    // results. I'm tired and I'll deal with it later.
    
    // Environment blending
    vec3 T = normalize((INV_VIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
    //vec3 B = normalize((INV_VIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);  // Even worse
    vec3 B = normalize((INV_VIEW_MATRIX * vec4(cross(TANGENT, BINORMAL), 0.0)).xyz);
    vec3 N = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    //T = normalize((inverse(MODEL_MATRIX) * vec4(T, 0.0)).xyz);
    //B = normalize((inverse(MODEL_MATRIX) * vec4(B, 0.0)).xyz);
    //N = normalize((inverse(MODEL_MATRIX) * vec4(N, 0.0)).xyz);
    mat3 TBN = mat3(T, B, N);
    
    vec3 moss_diff = texture(moss_diff_sampler, UV).rgb;
    vec3 moss_nor = texture(moss_nor_sampler, UV).rgb;
    vec3 rock_diff = texture(rock_diff_sampler, UV).rgb;
    vec3 rock_nor = texture(rock_nor_sampler, UV).rgb;
    
    //float blend_mask = clamp(N.y * 5.0 - 0.5, 0.0, 1.0);  // Regular normals
    float blend_mask = clamp(normalize(TBN * rock_nor).y * sharpness, 0.0, 1.0);
    ALBEDO = mix(rock_diff, moss_diff, blend_mask);
    NORMAL_MAP = mix(rock_nor, moss_nor, blend_mask);
}
