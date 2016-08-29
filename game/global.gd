extends Node

const COLOR_GRAY = Color(0.5, 0.5, 0.5, 1.0)
const COLOR_SAND = Color("fad689")
const COLOR_DESTROYER = Color(1.0, 1.0, 1.0, 1.0)

const PARTICLES_COLOR_GRAY = COLOR_GRAY
const PARTICLES_COLOR_SAND = COLOR_SAND
const PARTICLES_COLOR_DESTROYER = Color(0.3, 0.3, 0.3, 1.0)

const BOX_TYPE_GRAY = 1
const BOX_TYPE_SAND = 2
const BOX_TYPE_DESTROYER = 3

const BACKGROUND_COUNT = 3
const TEMPLATE_COUNT = 7

const GAME_MODE_NORMAL = 1
const GAME_MODE_SELECT = 2

const DESTROYER_LETHAL_VELOCITY = 150.0
const DESTROYER_LETHAL_VELOCITY_SQUARED = DESTROYER_LETHAL_VELOCITY * DESTROYER_LETHAL_VELOCITY

var template_to_load
var shape_precision
var blocks_used
var max_blocks_used
var game_mode

func _ready():
	randomize()

func start_game(level, mode):
	template_to_load = level
	game_mode = mode
	scene_switcher.switch_scene(load("res://game/ingame/ingame.tscn"))

func get_box_type_color(type):
	if type == BOX_TYPE_GRAY:
		return COLOR_GRAY
	if type == BOX_TYPE_SAND:
		return COLOR_SAND
	if type == BOX_TYPE_DESTROYER:
		return COLOR_DESTROYER
	assert(0)

func get_particles_color(type):
	if type == BOX_TYPE_GRAY:
		return PARTICLES_COLOR_GRAY
	if type == BOX_TYPE_SAND:
		return PARTICLES_COLOR_SAND
	if type == BOX_TYPE_DESTROYER:
		return PARTICLES_COLOR_DESTROYER
	assert(0)
