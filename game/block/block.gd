extends RigidBody2D

export(int, "None", "Gray", "Sand", "Destroyer") var type
var sprite

func _ready():
	sprite = get_node("sprite")
	set_type(type)
	set_contact_monitor(true)
	set_max_contacts_reported(3)

func set_type(typ):
	if sprite == null:
		sprite = get_node("sprite")
	type = typ
	sprite.set_modulate(global.get_box_type_color(typ))

	if type == global.BOX_TYPE_GRAY:
		set_weight(20.0)
	elif type == global.BOX_TYPE_SAND:
		set_weight(10.0)
		set_friction(0.8)
	elif type == global.BOX_TYPE_DESTROYER:
		set_weight(10.0)

	sprite.reload_texture(type)

func get_texture():
	return sprite.get_texture()

func launch(dir, speed):
	set_mode(MODE_RIGID)
	apply_impulse(Vector2(0, 0), dir * speed)
	set_layer_mask_bit(0, true)
	set_collision_mask_bit(0, true)

var velocity_before
var block_colliding = false
var ground_colliding = false

func _integrate_forces(state):
	var contact_count = state.get_contact_count()
	if contact_count == 0:
		block_colliding = false
		ground_colliding = false
		return

	var velocity = state.get_linear_velocity()
	if velocity_before == null:
		velocity_before = velocity

	for i in range(contact_count):
		var body = state.get_contact_collider_object(i)

		if body.is_in_group("block"):
			if block_colliding:
				continue
			block_colliding = true

			get_node("sample_player").play("blocks_collide")
			if type == global.BOX_TYPE_DESTROYER && \
					(velocity.length_squared() > global.DESTROYER_LETHAL_VELOCITY_SQUARED || \
					velocity_before.length_squared() > global.DESTROYER_LETHAL_VELOCITY_SQUARED):
				body.destroy()
		elif body.is_in_group("ground"):
			if ground_colliding:
				continue
			ground_colliding = true
			get_node("sample_player").play("sand_collide")
	velocity_before = velocity

func on_landed():
	if type == global.BOX_TYPE_DESTROYER:
		destroy()

func destroy():
	var explosion = preload("res://game/block/explosion.tscn").instance()
	get_tree().get_current_scene().add_child(explosion)
	explosion.start(get_global_pos(), global.get_particles_color(type))
	queue_free()
