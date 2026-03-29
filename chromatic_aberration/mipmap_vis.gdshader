shader_type canvas_item;

void fragment() {
    COLOR = textureLod(TEXTURE, UV, 0.0);  // 3rd parameter: mipmap level (lod)
    //COLOR = textureLod(TEXTURE, UV, 1.0);
    //COLOR = textureLod(TEXTURE, UV, 1.2);
    //COLOR = textureLod(TEXTURE, UV, 1.4);
    //COLOR = textureLod(TEXTURE, UV, 1.6);
    //COLOR = textureLod(TEXTURE, UV, 1.8);
    //COLOR = textureLod(TEXTURE, UV, 2.0);
    //COLOR = textureLod(TEXTURE, UV, 3.0);
    //COLOR = textureLod(TEXTURE, UV, 4.0);
    //COLOR = textureLod(TEXTURE, UV, 5.0);
    //COLOR = textureLod(TEXTURE, UV, 6.0);
    //COLOR = textureLod(TEXTURE, UV, 7.0);
    //COLOR = textureLod(TEXTURE, UV, 8.0);
    //COLOR = textureLod(TEXTURE, UV, 9.0);
    //COLOR = textureLod(TEXTURE, UV, 10.0);
}
