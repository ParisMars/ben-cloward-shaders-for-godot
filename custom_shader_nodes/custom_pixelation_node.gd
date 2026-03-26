@tool
class_name CustomQuantisationNode
extends VisualShaderNodeCustom


func _get_name() -> String:
    return "Quantise"


func _get_category() -> String:
    return "TheseAreMine"


func _get_description() -> String:
    return "Sexily quantise stuff..."


func _init() -> void:
    set_input_port_default_value(1, 16.0)


func _get_return_icon_type() -> PortType:
    return VisualShaderNode.PORT_TYPE_VECTOR_2D


func _get_input_port_count() -> int:
    return 2


func _get_input_port_name(port: int) -> String:
    match port:
        0:
            return "uv"
        1:
            return "quantisation_factor"
        _:
            return "Pointless"


func _get_input_port_type(port: int) -> PortType:
    match port:
        0:
            return PortType.PORT_TYPE_VECTOR_2D
        1:
            return PortType.PORT_TYPE_SCALAR
        _:
            return PortType.PORT_TYPE_BOOLEAN


func _get_output_port_count() -> int:
    return 1;


func _get_output_port_name(_port: int) -> String:
    return "quantised_uv"


func _get_output_port_type(_port: int) -> PortType:
    return VisualShaderNode.PORT_TYPE_VECTOR_2D


func _get_global_code(_mode: Shader.Mode) -> String:
    return """
    vec2 quantise(vec2 st, float quantise_amount) {
        return floor(st * quantise_amount) / quantise_amount;
    }
    """

func _get_code(input_vars: Array[String], output_vars: Array[String],
        _mode: Shader.Mode, _type: VisualShader.Type) -> String:
    var io_array = [output_vars[0], input_vars[0], input_vars[1]]
    return "%s = quantise(%s, %s);" % io_array
