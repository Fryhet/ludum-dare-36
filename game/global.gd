extends Node

const COLOR_BLACK = Color(0.0, 0.0, 0.0, 1.0)
const COLOR_YELLOW = Color(1.0, 1.0, 0.0, 1.0)

const BOX_TYPE_BLACK = 1
const BOX_TYPE_YELLOW = 2

func get_box_type_color(type):
	if type == BOX_TYPE_BLACK:
		return COLOR_BLACK
	if type == BOX_TYPE_YELLOW:
		return COLOR_YELLOW
	assert(0)

var template_to_load
var level_score
