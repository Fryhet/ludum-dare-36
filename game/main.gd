extends Container

func _on_play_pressed():
	global.start_game(0, global.GAME_MODE_NORMAL)

func _on_level_select_pressed():
	scene_switcher.switch_scene(load("res://game/level_select/level_select.tscn"))

func _on_help_pressed():
	scene_switcher.switch_scene(load("res://game/help/help.tscn"))

func _on_exit_pressed():
	get_tree().quit()
