extends Control

var visible = false

func _ready():
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel") && !event.is_pressed():
		set_menu_visible(!visible)

func set_menu_visible(visible):
	if visible:
		print("show")
	else:
		print("hide")
	self.visible = visible
	get_tree().set_pause(visible)
	var restart = get_node("../restart")
	restart.set("visibility/visible", !visible)
	
	set_button_enabled(get_node("../finished"), !visible)
	set_button_enabled(get_node("container/resume/button"), visible)
	set_button_enabled(get_node("container/restart/button"), visible)
	set_button_enabled(get_node("container/main_menu/button"), visible)

func set_button_enabled(button, enabled):
	if enabled:
		button.set_opacity(1.0)
	else:
		button.set_opacity(0.0)
	button.set_disabled(!enabled)

func _on_main_menu_pressed():
	set_menu_visible(false)
	get_tree().change_scene("res://game/main_menu/main_menu.tscn")

func _on_restart_pressed():
	set_menu_visible(false)
	get_node("../restart")._pressed()
