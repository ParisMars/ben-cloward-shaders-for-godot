shader_type spatial;

/* Transformations */
//------------------//
// Transforming direction vectors:
// normalize((matrix * vec4(direction, 0.0)).xyz)
// Transforming position vectors:
// (matrix * vec4(position, 1.0)).xyz

void fragment() {
    // Orientation mask
    vec3 N = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    float orientation_mask = dot(N, vec3(0.0, 1.0, 0.0));
    ALBEDO = vec3(orientation_mask);
    
    // Fresnel mask
    float fresnel = pow(dot(VIEW, NORMAL), 3.0);
    ALBEDO = vec3(fresnel);
    // Inverted
    ALBEDO = 1.0 - vec3(fresnel);
    
    // Distance mask
    ALBEDO = vec3(
            (length(CAMERA_POSITION_WORLD - NODE_POSITION_WORLD) - 1.0) / 5.0
    );
}

 //// Manual lighting
void light() {
    vec3 N = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    vec3 L = normalize((INV_VIEW_MATRIX * vec4(LIGHT, 0.0)).xyz);
    DIFFUSE_LIGHT = vec3(dot(L, N));
}
