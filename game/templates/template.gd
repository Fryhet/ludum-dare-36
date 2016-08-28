extends Node2D

func check():
	var children = get_children()
	var accum = 0.0
	for child in children:
		accum += child.get_points()
	global.level_score = clamp(accum / children.size(), 0.0, 1.0)
	if global.template_to_load >= global.TEMPLATE_COUNT - 1:
		get_tree().change_scene("res://game/end/end.tscn")
	else:
		get_tree().change_scene("res://game/after_level/after_level.tscn")
