extends Control

var container

var args = {}

func get_arg(name):
	assert(args.has(name))
	return args[name]

func _ready():
	container = get_node("/root/main/container")

func switch_scene(scene, args = {}):
	self.args = args

	var current = container.get_child(0)
	current.set_name("this_is_a_name_which_should_not_collide_with_anything_else")
	current.queue_free()
	container.add_child(scene.instance(), true)
