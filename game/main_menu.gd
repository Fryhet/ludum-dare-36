extends Container

func _on_play_pressed():
	global.start_game(0, global.GAME_MODE_NORMAL)


func _on_level_select_pressed():
	get_tree().change_scene("res://game/level_select/level_select.tscn")
