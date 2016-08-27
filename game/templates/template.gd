extends Node2D

func check():
	var children = get_children()
	for child in children:
		print(child.get_points())
