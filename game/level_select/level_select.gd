extends Control

export(PackedScene) var menu_entry

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel") && !event.is_pressed():
		_on_main_menu_pressed()

func _ready():
	set_process_input(true)
	var container = get_node("container")
	for i in range(0, global.TEMPLATE_COUNT):
		var entry = menu_entry.instance()
		container.add_child(entry)
		var button = entry.get_node("button")
		button.set_text(str(tr("LEVEL"), " ", i + 1))
		button.connect("pressed", self, "_on_level_selected", [i])

func _on_level_selected(index):
	sample_player.play("button")
	global.start_game(index, global.GAME_MODE_SELECT)

func _on_main_menu_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(preload("res://game/main_menu/main_menu.tscn"))
