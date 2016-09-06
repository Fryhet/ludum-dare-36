extends Control

var template_id
var precision
var game_mode

func _ready():
	template_id = scene_switcher.get_arg("template_id")
	precision = scene_switcher.get_arg("precision")
	game_mode = scene_switcher.get_arg("game_mode")

	var stats = get_node("stats")
	stats.set_precision(precision)
	stats.set_blocks_used(scene_switcher.get_arg("blocks_used"), scene_switcher.get_arg("max_blocks_used"))
	stats.generate_verdict()

func _on_retry_pressed():
	sample_player.play("button")
	global.start_game(template_id, game_mode)

func _on_next_level_pressed():
	sample_player.play("button")
	global.start_game(template_id + 1, global.GAME_MODE_NORMAL)

func _on_change_level_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(load("res://game/level_select/level_select.tscn"))

func _on_main_menu_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(load("res://game/main_menu/main_menu.tscn"))
