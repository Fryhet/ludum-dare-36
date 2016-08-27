extends Node

func _ready():
	var template = load(str("res://game/templates/template_", global.template_to_load, ".tscn"))
	get_node("template").add_child(template.instance())

