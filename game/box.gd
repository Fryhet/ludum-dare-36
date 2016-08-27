extends RigidBody2D

func launch(dir, speed):
	set_mode(MODE_RIGID)
	apply_impulse(Vector2(0, 0), dir * speed)
	set_layer_mask_bit(0, true)
	set_collision_mask_bit(0, true)