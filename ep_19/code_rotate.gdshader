shader_type canvas_item;

/* It's rotating at twice the speed since you're doing it all twice */

uniform sampler2D tex;

void fragment() {
	vec2 uv = UV - vec2(0.5);
    float angle = TIME;
    
    // With a matrix
    mat2 rotation_matrix = mat2(
        vec2(cos(angle), -sin(angle)),
        vec2(sin(angle), cos(angle))
    );
    uv *= rotation_matrix;
    
    // Without a matrix
    // x, y = ..., not uv.x, uv.y += ...
    float x = uv.x * cos(TIME) - uv.y * sin(TIME);
    float y = uv.x * sin(TIME) + uv.y * cos(TIME);
    uv = vec2(x, y);
    
    uv += vec2(0.5);
    COLOR = texture(tex, uv);
}
