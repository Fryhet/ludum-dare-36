extends Control

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel") && !event.is_pressed():
		_on_main_menu_pressed()

func _ready():
	translate()
	set_process_input(true)

func translate():
	var pavol = get_node("panel/pavol_molcsan")
	pavol.set_bbcode(pavol.get_bbcode().replace("GRAPHICS", tr("GRAPHICS")))
	var milan = get_node("panel/milan_vasko")
	milan.set_bbcode(milan.get_bbcode().replace("PROGRAMMING", tr("PROGRAMMING")))
	var sounds = get_node("panel/sounds")
	sounds.set_bbcode(sounds.get_bbcode().replace("CREDITS_SOUNDS", tr("CREDITS_SOUNDS")))
	var ludum_dare = get_node("panel/created_in")
	ludum_dare.set_bbcode(ludum_dare.get_bbcode().replace("CREDITS_LUDUM_DARE", tr("CREDITS_LUDUM_DARE")))

func _on_main_menu_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(preload("res://game/main_menu/main_menu.tscn"))
