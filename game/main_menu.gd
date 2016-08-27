extends Container

func _on_play_pressed():
	global.template_to_load = 0
	get_tree().change_scene("res://game/building.tscn")
