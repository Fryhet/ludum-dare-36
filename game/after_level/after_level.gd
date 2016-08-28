extends Control

func _ready():
	get_node("score").set_text(create_text(global.level_score))

func create_text(score):
	if global.template_to_load == 0:
		if score > 0.50:
			return str("Good job! ", to_percent_string(score))
		return str("You can do better! ", to_percent_string(score))
	
	if score > 0.95:
		return str("Excellent score, we didn't know this was possible! ", to_percent_string(score))
	if score > 0.80:
		return str("Wow, great job! ", to_percent_string(score))
	if score > 0.60:
		return str("Nice! ", to_percent_string(score))
	if score > 0.40:
		return str("Not bad! ", to_percent_string(score))
	if score > 0.20:
		return str("You can do better! ", to_percent_string(score))
	return str("Sorry, that's not very good. ", to_percent_string(score))

func to_percent_string(score):
	return "%.2f%%" % (score * 100.0)

func _on_retry_pressed():
	global.start_game(global.template_to_load, global.game_mode)

func _on_next_level_pressed():
	global.start_game(global.template_to_load + 1, global.GAME_MODE_NORMAL)

func _on_change_level_pressed():
	get_tree().change_scene("res://game/level_select/level_select.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene("res://game/main_menu/main_menu.tscn")
