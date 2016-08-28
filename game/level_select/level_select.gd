extends Control

export(PackedScene) var menu_entry

func _ready():
	var container = get_node("container")
	for i in range(0, global.TEMPLATE_COUNT):
		var entry = menu_entry.instance()
		container.add_child(entry)
		var button = entry.get_node("button")
		button.set_text(str("Level ", i + 1))
		button.connect("pressed", self, "_on_level_selected", [i])

func _on_level_selected(index):
	global.start_game(index, global.GAME_MODE_SELECT)

func _on_main_menu_pressed():
	get_tree().change_scene("res://game/main_menu/main_menu.tscn")
