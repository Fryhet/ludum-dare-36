extends Button

func show():
	get_node("animation").play("restart_button_appear")

func _pressed():
	# yeah, not the ideal way, but who cares?
	scene_switcher.switch_scene("res://game/ingame/ingame.tscn")
