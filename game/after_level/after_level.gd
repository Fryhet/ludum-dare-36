extends Control

func _ready():
	get_node("score").set_text(create_text(global.level_score))

func create_text(score):
	if score > 0.95:
		return str("Excellent score, we didn't know this was possible! ", to_percent_string(score))
	if score > 0.80:
		return str("Wow, great job! ", to_percent_string(score))
	if score > 0.60:
		return str("Nice! ", to_percent_string(score))
	if score > 0.40:
		return str("Not bad! ", to_percent_string(score))
	if score > 0.20:
		return str("You can do better. ", to_percent_string(score))
	return str("Sorry, that's not very good. ", to_percent_string(score))

func to_percent_string(score):
	return "%.2f%%" % (score * 100.0)

func _on_retry_pressed():
	get_tree().change_scene("res://game/building.tscn")

func _on_next_level_pressed():
	print("TODO, doing what retry does in the meanwhile...")
	_on_retry_pressed()

func _on_main_menu_pressed():
	get_tree().change_scene("res://game/main_menu.tscn")
