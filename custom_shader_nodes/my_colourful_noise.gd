@tool
class_name MyColourfulNoise
extends VisualShaderNodeCustom


func _get_name() -> String:
    return "ThreeChannelNoise"


func _get_description() -> String:
    return """
    A noise texture with offset noise data in each channel. This performs three
    texture reads and is less efficient than channel packing your own noise
    texture.
    """

func _get_return_icon_type() -> PortType:
    return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
    return 2


func _get_input_port_name(port: int):
    match port:
        0:
            return "uv"
        1:
            return "sampler"


func _get_input_port_type(port: int):
    match port:
        0:
            return VisualShaderNode.PORT_TYPE_VECTOR_2D
        1:
            return VisualShaderNode.PORT_TYPE_SAMPLER


func _get_output_port_count() -> int:
    return 1


func _get_output_port_name(_port: int) -> String:
    return "colour"


func _get_output_port_type(_port: int) -> PortType:
    return VisualShaderNode.PortType.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode: Shader.Mode) -> String:
    return """
        vec3 create_three_channel_noise(vec2 st, sampler2D ns) {
            float noise_r = texture(ns, st).r;
            float noise_g = texture(ns, st + vec2(0.27, 0.85)).r;
            float noise_b = texture(ns, st - vec2(0.47, -0.31)).r;
            return vec3(noise_r, noise_g, noise_b);
        }
    """

func _get_code(input_vars: Array[String], output_vars: Array[String],
        _mode: Shader.Mode, _type: VisualShader.Type) -> String:
    var io_array = [output_vars[0], input_vars[0], input_vars[1]]
    return "%s = create_three_channel_noise(%s, %s);" % io_array
