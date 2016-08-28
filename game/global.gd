extends Node

const COLOR_GRAY = Color(0.5, 0.5, 0.5, 1.0)
const COLOR_YELLOW = Color(1.0, 1.0, 0.0, 1.0)

const BOX_TYPE_GRAY = 1
const BOX_TYPE_YELLOW = 2

const TEMPLATE_COUNT = 2

var template_to_load
var level_score

func get_box_type_color(type):
	if type == BOX_TYPE_GRAY:
		return COLOR_GRAY
	if type == BOX_TYPE_YELLOW:
		return COLOR_YELLOW
	assert(0)

