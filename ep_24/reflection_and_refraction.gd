extends Node3D


@export var images: Array[Image] = []


func _ready() -> void:
    var cubemap: Cubemap = Cubemap.new()
    cubemap.create_from_images(images)
    ResourceSaver.save(cubemap, "res://ep_24/cube_map_textures/cubemap.res", ResourceSaver.FLAG_COMPRESS)
