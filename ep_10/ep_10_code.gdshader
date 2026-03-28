shader_type spatial;
uniform sampler2D matcap_sampler : source_color;

uniform sampler2D moss_diff_sampler : source_color;
uniform sampler2D moss_nor_sampler : hint_normal;
uniform sampler2D rock_diff_sampler : source_color;
uniform sampler2D rock_nor_sampler : hint_normal;

uniform float sharpness : hint_range(0.0, 50.0) = 5.0;

void fragment() {
    // Matcap shader
    vec2 matcap_uv = (NORMAL * vec3(0.5, -0.5, 0.5) + 0.5).xy;
    vec3 matcap = texture(matcap_sampler, matcap_uv).rgb;
    ALBEDO = matcap;
    
    // Environment blending
    // https://godotforums.org/d/27986-custom-normal-map-shader/8
    // https://www.scratchapixel.com/lessons/mathematics-physics-for-computer-graphics/geometry/transforming-normals.html
    // https://www.gamedeveloper.com/programming/three-normal-mapping-techniques-explained-for-the-mathematically-uninclined
    mat4 orthonormal_IVM = transpose(inverse(INV_VIEW_MATRIX));
    vec3 T = normalize((orthonormal_IVM * vec4(TANGENT, 0.0)).xyz);
    vec3 B = normalize((orthonormal_IVM * vec4(BINORMAL, 0.0)).xyz);
    vec3 N = normalize((orthonormal_IVM * vec4(NORMAL, 0.0)).xyz);
    //vec3 T = normalize((INV_VIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
    //vec3 B = normalize((INV_VIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);
    //vec3 N = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    mat3 TBN = mat3(T, B, N);
    
    vec3 moss_diff = texture(moss_diff_sampler, UV).rgb;
    vec3 moss_nor = texture(moss_nor_sampler, UV).rgb;
    vec3 rock_diff = texture(rock_diff_sampler, UV).rgb;
    vec3 rock_nor = texture(rock_nor_sampler, UV).rgb;
    
    //float blend_mask = clamp(N.y * 5.0 - 0.5, 0.0, 1.0);  // Regular normals
    float blend_mask = clamp(normalize(TBN * rock_nor).y * sharpness, 0.0, 1.0);
    ALBEDO = mix(rock_diff, moss_diff, blend_mask);
    NORMAL_MAP = mix(rock_nor, moss_nor, blend_mask);
    
    /* DEBUG STUFF */
    // |AxB| = |A||B|sin(theta) -- don't need to normalise for perp unit vecs
    //NORMAL_MAP = moss_nor;
    //vec3 BITANGENT = cross(NORMAL, TANGENT);
    //ALBEDO = BINORMAL;
    //ALBEDO = BITANGENT;  Same as binormal
    //ALBEDO = NORMAL;
    //ALBEDO = NORMAL_MAP;
    //ALBEDO = TANGENT;
    // normal - z, tangent - x, bitangent - y
}
