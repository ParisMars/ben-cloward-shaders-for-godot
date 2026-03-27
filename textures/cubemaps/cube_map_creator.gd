@tool
class_name CubeMapCreator
extends Node

## Tool for creating cubemaps from images
##
## In Blender (using the pie menu) -- left, right, bottom, top, front, back
## This produces the correct image sequence in Godot
## Change the camera setting Type: Panoramic

@export_tool_button("Create Cubemap") var ccm = create_cubemap
@export var cubemap_name: String = ""
@export var folder_path: String = "res://textures/cubemaps/assembled/"
@export var images: Array[Image] = []


func create_cubemap() -> void:
    if cubemap_name == "":
        return

    if folder_path == "":
        return

    var cubemap: Cubemap = Cubemap.new()
    cubemap.create_from_images(images)
    ResourceSaver.save(
        cubemap,
        folder_path + "%s.res" % cubemap_name.to_snake_case(),
        ResourceSaver.FLAG_COMPRESS
    )

    cubemap_name = ""
    folder_path = "res://textures/cubemaps/assembled/"
