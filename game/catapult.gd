extends RigidBody2D

const RED_COLOR = Color(1.0, 0.0, 0.0, 1.0)
const GREEN_COLOR = Color(0.0, 1.0, 0.0, 1.0)

const MAX_SPEED = 1000.0
const CLICK_RADIUS = 300.0
const CLICK_RADIUS_SQUARED = CLICK_RADIUS * CLICK_RADIUS
const MAX_LENGTH = 200.0
const MAX_LENGTH_SQUARED = MAX_LENGTH * MAX_LENGTH

var dragging = false
var end

func _ready():
	set_process_input(true)
	end = get_pos()

func _draw():
	if dragging:
		var target = end - get_pos()
		var length = target.length()
		if length > MAX_LENGTH:
			target = target / length * MAX_LENGTH
			length = MAX_LENGTH
		var color = RED_COLOR.linear_interpolate(GREEN_COLOR, length / MAX_LENGTH)
		
		draw_line(Vector2(0, 0), target, color, 2.0)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		end = event.global_pos
		update()
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.is_pressed():
			dragging = (event.global_pos - get_global_pos()).length_squared() < CLICK_RADIUS_SQUARED
		else:
			if dragging:
				dragging = false
				var diff = event.global_pos - get_global_pos()
				var length = diff.length()
				if length > MAX_LENGTH:
					length = MAX_LENGTH
				var dir = -diff.normalized()
				apply_impulse(Vector2(0, 0), dir * MAX_SPEED * (length / MAX_LENGTH))
				set_gravity_scale(1.0)

