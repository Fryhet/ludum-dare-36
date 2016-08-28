extends RigidBody2D

export(int, "None", "Gray", "Sand") var type
var sprite

func _ready():
	sprite = get_node("sprite")
	var rect = sprite.get_region_rect()
	rect.pos.x = (randi() % (sprite.get_texture().get_width() / int(rect.size.x))) * rect.size.x
	sprite.set_region_rect(rect)
	set_type(type)

func set_type(typ):
	if sprite == null:
		sprite = get_node("sprite")
	type = typ
	sprite.set_modulate(global.get_box_type_color(typ))

func get_texture():
	return sprite.get_texture()

func launch(dir, speed):
	set_mode(MODE_RIGID)
	apply_impulse(Vector2(0, 0), dir * speed)
	set_layer_mask_bit(0, true)
	set_collision_mask_bit(0, true)