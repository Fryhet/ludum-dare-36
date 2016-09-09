extends Control

func _ready():
	get_node("sounds").set_pressed(AudioServer.get_fx_global_volume_scale() > 0.5)
	set_menu_visible(false)
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel") && !event.is_pressed():
		set_menu_visible(!is_visible())

func set_menu_visible(visible):
	set_hidden(!visible)
	get_tree().set_pause(visible)

	get_node("../restart").set_hidden(visible)
	get_node("../finished").set_hidden(visible)
	get_node("resume").set_disabled(!visible)
	get_node("restart").set_disabled(!visible)
	get_node("main_menu").set_disabled(!visible)

func _on_sounds_toggled(pressed):
	if pressed:
		AudioServer.set_fx_global_volume_scale(1.0)
	else:
		AudioServer.set_fx_global_volume_scale(0.0)

func _on_restart_pressed():
	sample_player.play("button")
	set_menu_visible(false)
	get_node("../restart")._pressed()

func _on_main_menu_pressed():
	sample_player.play("button")
	set_menu_visible(false)
	scene_switcher.switch_scene(load("res://game/main_menu/main_menu.tscn"))
