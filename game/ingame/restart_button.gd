extends Button

func show():
	get_node("animation").play("restart_button_appear")

func _pressed():
	# yeah, not the ideal way, but who cares?
	sample_player.play("button")
	scene_switcher.switch_scene(load("res://game/ingame/ingame.tscn"))
