shader_type canvas_item;

uniform sampler2D txt;

void fragment() {
    COLOR = texture(TEXTURE, UV);
}
