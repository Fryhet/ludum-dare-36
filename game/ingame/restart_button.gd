extends Button

func show():
	get_node("animation").play("restart_button_appear")

func _pressed():
	# yeah, not the ideal way, but who cares?
	sample_player.play("button")
	var ingame = get_node("..")
	global.start_game(ingame.template_id, ingame.game_mode)
