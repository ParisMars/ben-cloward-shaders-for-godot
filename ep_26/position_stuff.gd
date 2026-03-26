extends Node3D

var colour: Color = Color.WHITE


func set_hue_based_on_position(mat: BaseMaterial3D) -> void:
    var pos: Vector3 = global_position
    var x: float = pos.x
    var y: float = pos.y
    var z: float = pos.z
    colour = Color.from_hsv(sin(x + y + z), 1.0, 1.0, 1.0)
    mat.albedo_color = colour
