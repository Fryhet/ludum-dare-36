extends Node2D

export(int) var max_blocks

func check_shape_precision():
	var children = get_children()
	var accum = 0.0
	for child in children:
		accum += child.get_points()
	return clamp(accum / children.size(), 0.0, 1.0)
