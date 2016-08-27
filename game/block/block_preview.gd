extends Node2D

export(int, "None", "Black", "Yellow") var type
var sprite

var pressed = false

func _ready():
	sprite = get_node("sprite")
	set_type(type)
	set_process_input(true)

func set_type(typ):
	type = typ
	sprite.set_modulate(global.get_box_type_color(typ))

func get_texture():
	return sprite.get_texture()

func _input(event):
	if event.type != InputEvent.MOUSE_BUTTON:
		return
	if event.is_pressed():
		if global_pos_inside(event.global_pos):
			pressed = true
		return
	if !pressed:
		return
	pressed = false
	if global_pos_inside(event.global_pos):
		on_click()

func global_pos_inside(global_pos):
	var size = sprite.get_texture().get_size() * sprite.get_scale()
	var rect = Rect2(sprite.get_global_pos() - (size / 2.0), size)
	return rect.has_point(global_pos)

func on_click():
	var sling_shot = get_node("/root/main/sling_shot")
	sling_shot.current_box_type = type
	sling_shot.respawn_box()
	
