@tool
class_name CustomTriplanarProjection
extends VisualShaderNodeCustom


func _get_name() -> String:
    return "MyTriplanarProjection"


func _get_category() -> String:
    return "Projection"

func _get_description() -> String:
    return "Triplanar projection ('box projection')"


func _init() -> void:
    set_input_port_default_value(3, 16.0)
    set_input_port_default_value(4, 1.0)


func _get_return_icon_type() -> PortType:
    return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
    return 5


func _get_input_port_name(port: int):
    match port:
        0:
            return "world_normal"
        1:
            return "world_vertex"
        2:
            return "tp_texture"
        3:
            return "sharpness"
        4:
            return "tiling_fac"


func _get_input_port_type(port: int):
    match port:
        0:
            return VisualShaderNode.PORT_TYPE_VECTOR_3D
        1:
            return VisualShaderNode.PORT_TYPE_VECTOR_3D
        2:
            return VisualShaderNode.PORT_TYPE_SAMPLER
        3:
            return VisualShaderNode.PORT_TYPE_SCALAR
        4:
            return VisualShaderNode.PORT_TYPE_SCALAR


func _get_output_port_count() -> int:
    return 1


func _get_output_port_name(_port: int) -> String:
    return "colour"


func _get_output_port_type(_port: int) -> PortType:
    return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode: Shader.Mode) -> String:
    return """
vec3 tri_planar_project(
        vec3 world_normal,
        vec3 world_vertex,
        sampler2D tp_texture,
        float sharpness,
        float tiling_fac) {

    vec3 adjusted_normals = pow(abs(world_normal), vec3(sharpness));
    vec3 dir_masks = adjusted_normals / dot(adjusted_normals, vec3(1.0));
    vec3 sign_stuff = sign(world_normal) * vec3(-1.0, 1.0, 1.0);

    world_vertex *= vec3(1.0, -1.0, 1.0) * tiling_fac;
    vec2 x_proj = world_vertex.zy * vec2(sign_stuff.x, 1.0);  // Swap yz, else projection is sideways
    vec2 y_proj = world_vertex.xz * vec2(sign_stuff.y, 1.0);
    vec2 z_proj = world_vertex.xy * vec2(sign_stuff.z, 1.0);
    vec3 combined_projected_textures = mix(
        mix(
            texture(tp_texture, x_proj).rgb,
            texture(tp_texture, y_proj).rgb,
            dir_masks.y
        ),
        texture(tp_texture, z_proj).rgb,
        dir_masks.z
    );

    return combined_projected_textures;
}
    """


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: Shader.Mode, _type: VisualShader.Type) -> String:
    var io_array = [
        output_vars[0],
        input_vars[0],
        input_vars[1],
        input_vars[2],
        input_vars[3],
        input_vars[4],
    ]
    return "%s = tri_planar_project(%s, %s, %s, %s, %s);" % io_array
