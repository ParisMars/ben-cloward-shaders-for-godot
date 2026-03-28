shader_type spatial;

/* Transformations */
//------------------//
// Transforming directions:
// (matrix * vec4(direction, 0.0)).xyz
// Transforming non-directions:
// (matrix * vec4(non_direction, 1.0)).xyz
//
// Spaces: model -> world -> view -> clip -> screen
// Matrices: Anything that doesn't have "inv" in front of it is going
// from left to right on the above, um, I'll call it a diagram.
//
// Model space is also called "object space", "local space".
// View space is also called "camera space", "eye space".
// World space is also called "global space".

void fragment() {
    // Orientation mask
    vec3 N = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;  // From view to world
    float orientation_mask = dot(N, vec3(0.0, 1.0, 0.0));
    ALBEDO = vec3(orientation_mask);
    
    // Fresnel
    float fresnel = pow(dot(VIEW, NORMAL), 3.0);
    ALBEDO = vec3(fresnel);
    // Inverted
    ALBEDO = 1.0 - vec3(fresnel);
    
    // Distance from thing effect
    ALBEDO = vec3(
        (length(CAMERA_POSITION_WORLD - NODE_POSITION_WORLD) - 1.0) / 5.0
    );
}

 //// Manual lighting
//void light() {
    //vec3 N = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
    //vec3 L = (INV_VIEW_MATRIX * vec4(LIGHT, 0.0)).xyz;
    //DIFFUSE_LIGHT = vec3(dot(L, N));
//}
