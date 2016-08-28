extends Node

const COLOR_GRAY = Color(0.5, 0.5, 0.5, 1.0)
const COLOR_YELLOW = Color(1.0, 1.0, 0.0, 1.0)

const BOX_TYPE_GRAY = 1
const BOX_TYPE_YELLOW = 2

const TEMPLATE_COUNT = 2

const GAME_MODE_NORMAL = 1
const GAME_MODE_SELECT = 2

var template_to_load
var level_score
var game_mode

func _ready():
	randomize()

func start_game(level, mode):
	template_to_load = level
	game_mode = mode
	get_tree().change_scene("res://game/building.tscn")

func get_box_type_color(type):
	if type == BOX_TYPE_GRAY:
		return COLOR_GRAY
	if type == BOX_TYPE_YELLOW:
		return COLOR_YELLOW
	assert(0)

