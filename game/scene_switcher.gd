extends Control

var container

func _ready():
	container = get_node("/root/main/container")

func switch_scene(scene):
	container.get_child(0).queue_free()
	container.add_child(scene.instance())
