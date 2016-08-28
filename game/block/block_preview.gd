extends Area2D

export(int, "None", "Gray", "Sand", "Destroyer") var type
var sprite
var shape

var pressed = false

func _ready():
	sprite = get_node("sprite")
	var rect = sprite.get_region_rect()
	rect.pos.x = (randi() % (sprite.get_texture().get_width() / int(rect.size.x))) * rect.size.x
	sprite.set_region_rect(rect)
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
	var slingshot = get_node("/root/ingame/slingshot")
	slingshot.current_box_type = type
	slingshot.respawn_box()

func get_points():
	var points = 0.0
	for body in get_overlapping_bodies():
		if body.type != type:
			continue
		# TODO: a more accurate calculation, this just takes distance into account
		var dist = clamp((body.get_global_pos() - get_global_pos()).length() / shape.get_shape().get_extents().width / 2.0, 0.0, 1.0)
		points += 1.0 - dist
	return points

