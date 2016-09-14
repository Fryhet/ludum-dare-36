extends Control

func _ready():
	var fullscreen = get_node("fullscreen")

	if global.is_mobile_build():
		get_tree().set_auto_accept_quit(true)

		fullscreen.set_hidden(true)

	fullscreen.set_pressed(OS.is_window_fullscreen())
	get_node("sounds").set_pressed(AudioServer.get_fx_global_volume_scale() > 0.5)

func on_button_pressed():
	sample_player.play("button")
	if global.is_mobile_build():
		get_tree().set_auto_accept_quit(false)

func _on_play_pressed():
	on_button_pressed()
	global.start_game(0, global.GAME_MODE_NORMAL)

func _on_level_select_pressed():
	on_button_pressed()
	scene_switcher.switch_scene(load("res://game/level_select/level_select.tscn"))

func _on_help_pressed():
	on_button_pressed()
	scene_switcher.switch_scene(load("res://game/help/help.tscn"))

func _on_fullscreen_toggled(pressed):
	OS.set_window_fullscreen(pressed)

func _on_sounds_toggled(pressed):
	if pressed:
		AudioServer.set_fx_global_volume_scale(1.0)
	else:
		AudioServer.set_fx_global_volume_scale(0.0)

func _on_credits_pressed():
	on_button_pressed()
	scene_switcher.switch_scene(load("res://game/credits/credits.tscn"))

func _on_exit_pressed():
	get_tree().quit()

