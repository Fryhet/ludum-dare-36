extends Container

func _on_play_pressed():
	global.template_to_load = 0
	get_tree().change_scene("res://game/building.tscn")


func _on_level_select_pressed():
	get_tree().change_scene("res://game/level_select/level_select.tscn")
