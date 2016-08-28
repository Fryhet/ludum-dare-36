extends Node2D

func check():
	var children = get_children()
	var accum = 0.0
	for child in children:
		accum += child.get_points()
	global.level_score = accum / children.size()
	get_tree().change_scene("res://game/after_level/after_level.tscn")
