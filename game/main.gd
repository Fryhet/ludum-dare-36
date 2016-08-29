extends Control

func _ready():
	get_node("sounds").set_pressed(AudioServer.get_fx_global_volume_scale() > 0.5)

func _on_play_pressed():
	sample_player.play("button")
	global.start_game(0, global.GAME_MODE_NORMAL)

func _on_level_select_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(load("res://game/level_select/level_select.tscn"))

func _on_help_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(load("res://game/help/help.tscn"))

func _on_sounds_toggled(pressed):
	if pressed:
		AudioServer.set_fx_global_volume_scale(1.0)
	else:
		AudioServer.set_fx_global_volume_scale(0.0)

func _on_credits_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(load("res://game/credits/credits.tscn"))

func _on_exit_pressed():
	get_tree().quit()

