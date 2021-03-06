extends Node

const COLOR_GRAY = Color(0.5, 0.5, 0.5, 1.0)
const COLOR_SAND = Color("fad689")
const COLOR_DESTROYER = Color(1.0, 1.0, 1.0, 1.0)

const OUTLINE_BAD_COLOR = Color(0.0, 0.0, 0.0, 0.0)
const OUTLINE_GOOD_COLOR = Color("69ff44")

const PARTICLES_COLOR_GRAY = COLOR_GRAY
const PARTICLES_COLOR_SAND = COLOR_SAND
const PARTICLES_COLOR_DESTROYER = Color(0.3, 0.3, 0.3, 1.0)

const BOX_TYPE_GRAY = 1
const BOX_TYPE_SAND = 2
const BOX_TYPE_DESTROYER = 3

const BACKGROUND_COUNT = 3
const TEMPLATE_COUNT = 8

const GAME_MODE_NORMAL = 1
const GAME_MODE_SELECT = 2

const DESTROYER_LETHAL_VELOCITY = 150.0
const DESTROYER_LETHAL_VELOCITY_SQUARED = DESTROYER_LETHAL_VELOCITY * DESTROYER_LETHAL_VELOCITY

func _ready():
	randomize()

func start_game(level, mode):
	scene_switcher.switch_scene(load("res://game/ingame/ingame.tscn"), {"template_id": level, "game_mode": mode})

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

func scored_enough(precision):
	return precision > 0.40

func is_mobile_build():
	var os_name = OS.get_name()
	return os_name == "Android" || os_name == "iOS"
