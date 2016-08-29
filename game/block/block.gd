extends RigidBody2D

export(int, "None", "Gray", "Sand", "Destroyer") var type
var sprite

func _ready():
	sprite = get_node("sprite")
	set_type(type)

func set_type(typ):
	if sprite == null:
		sprite = get_node("sprite")
	type = typ
	sprite.set_modulate(global.get_box_type_color(typ))
	disconnect_rigidbody()
	if type == global.BOX_TYPE_GRAY:
		set_weight(20.0)
	elif type == global.BOX_TYPE_SAND:
		set_weight(10.0)
		set_friction(0.8)
	elif type == global.BOX_TYPE_DESTROYER:
		set_weight(10.0)
		connect_rigidbody()

	sprite.reload_texture(type)

func connect_rigidbody():
	set_contact_monitor(true)
	set_max_contacts_reported(3)
	connect("body_enter", self, "on_body_enter")

func disconnect_rigidbody():
	set_contact_monitor(false)
	set_max_contacts_reported(0)
	if is_connected("body_enter", self, "on_body_enter"):
		disconnect("body_enter", self, "on_body_enter")

func get_texture():
	return sprite.get_texture()

func launch(dir, speed):
	set_mode(MODE_RIGID)
	apply_impulse(Vector2(0, 0), dir * speed)
	set_layer_mask_bit(0, true)
	set_collision_mask_bit(0, true)

func on_body_enter(body):
	if body.is_in_group("block") && get_linear_velocity().length_squared() > global.DESTROYER_LETHAL_VELOCITY_SQUARED:
		body.destroy()

func on_landed():
	if type == global.BOX_TYPE_DESTROYER:
		destroy()

func destroy():
	var explosion = preload("res://game/block/explosion.tscn").instance()
	get_tree().get_current_scene().add_child(explosion)
	explosion.start(get_global_pos(), global.get_particles_color(type))
	queue_free()
