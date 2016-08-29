extends Control

func _ready():
	var stats = get_node("stats")
	stats.set_shape_precision(global.shape_precision)
	stats.set_blocks_used(global.blocks_used, global.max_blocks_used)
	stats.generate_verdict()

func _on_retry_pressed():
	global.start_game(global.template_to_load, global.game_mode)

func _on_next_level_pressed():
	global.start_game(global.template_to_load + 1, global.GAME_MODE_NORMAL)

func _on_change_level_pressed():
	scene_switcher.switch_scene(load("res://game/level_select/level_select.tscn"))

func _on_main_menu_pressed():
	scene_switcher.switch_scene(load("res://game/main_menu/main_menu.tscn"))
