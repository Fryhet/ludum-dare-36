extends Node

func _ready():
	var background_scene = load(str("res://game/backgrounds/background_", randi() % global.BACKGROUND_COUNT, ".tscn"))
	var background = background_scene.instance()
	get_node("background").add_child(background)
	background.get_node("animation_player").seek(get_node("/root/main/day_night").get_current_animation_time())

	var template_scene = load(str("res://game/templates/template_", global.template_to_load, ".tscn"))
	var template = template_scene.instance()
	get_node("template").add_child(template)
	var block_counter = get_node("block_counter")
	block_counter.set_max_used(template.max_blocks)
	block_counter.refresh_text()
	get_node("slingshot").respawn_box()

func _on_finished_pressed():
	var block_counter = get_node("block_counter")

	global.shape_precision = get_node("template/template").check_shape_precision()
	global.blocks_used = block_counter.used
	global.max_blocks_used = block_counter.max_used

	if global.game_mode == global.GAME_MODE_NORMAL:
		if global.template_to_load >= global.TEMPLATE_COUNT - 1:
			scene_switcher.switch_scene(load("res://game/after_level/after_level_end.tscn"))
		else:
			scene_switcher.switch_scene(load("res://game/after_level/after_level_normal.tscn"))
	elif global.game_mode == global.GAME_MODE_SELECT:
		scene_switcher.switch_scene(load("res://game/after_level/after_level_select.tscn"))
