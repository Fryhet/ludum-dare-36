extends RigidBody2D

var type
var sprite

func _ready():
	sprite = get_node("sprite")
	set_type(global.BOX_TYPE_YELLOW)

func set_type(typ):
	type = typ
	sprite.set_modulate(global.get_box_type_color(typ))

func get_texture():
	return sprite.get_texture()

func launch(dir, speed):
	set_mode(MODE_RIGID)
	apply_impulse(Vector2(0, 0), dir * speed)
	set_layer_mask_bit(0, true)
	set_collision_mask_bit(0, true)