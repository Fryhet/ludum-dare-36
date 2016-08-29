extends Control

func _ready():
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel") && !event.is_pressed():
		_on_main_menu_pressed()

func _on_main_menu_pressed():
	scene_switcher.switch_scene(preload("res://game/main_menu/main_menu.tscn"))
