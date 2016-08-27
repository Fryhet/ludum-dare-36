extends Area2D

export(int, "None", "Gray", "Yellow") var type
var sprite
var shape

var pressed = false

func _ready():
	sprite = get_node("sprite")
	shape = get_node("shape")
	set_type(type)
	set_process_input(true)

func set_type(typ):
	type = typ
	sprite.set_modulate(global.get_box_type_color(typ))

func get_texture():
	return sprite.get_texture()

func _input_event(viewport, event, shape_idx):
	if event.type != InputEvent.MOUSE_BUTTON:
		return
	if event.is_pressed():
		pressed = true
		return
	if !pressed:
		return
	pressed = false
	on_click()

func on_click():
	var sling_shot = get_node("/root/main/sling_shot")
	sling_shot.current_box_type = type
	sling_shot.respawn_box()

func get_points():
	var points = 0.0
	for body in get_overlapping_bodies():
		if body.type != type:
			continue
		# TODO: a more accurate calculation, this just takes distance into account
		var dist = clamp((body.get_global_pos() - get_global_pos()).length() / shape.get_shape().get_extents().width / 2.0, 0.0, 1.0)
		points += 1.0 - dist
	return points

