extends Sprite

export(PackedScene) var box_scene

const RED_COLOR = Color(1.0, 0.0, 0.0, 1.0)
const GREEN_COLOR = Color(0.0, 1.0, 0.0, 1.0)

const MAX_SPEED = 1000.0
const CLICK_RADIUS = 300.0
const CLICK_RADIUS_SQUARED = CLICK_RADIUS * CLICK_RADIUS
const MAX_LENGTH = 200.0
const MAX_LENGTH_SQUARED = MAX_LENGTH * MAX_LENGTH

var dragging = false
var end
var time_launched = 0.0

var current_box

func is_launched():
	return is_processing()

func _ready():
	set_process_input(true)
	end = get_pos()
	spawn_box()

func spawn_box():
	time_launched = 0.0
	current_box = box_scene.instance()
	get_node("..").call_deferred("add_child", current_box)
	current_box.set_pos(get_pos())

func _draw():
	if !dragging:
		return

	var target = end - get_pos()
	var length = target.length()
	if length > MAX_LENGTH:
		target = target / length * MAX_LENGTH
		length = MAX_LENGTH
	var color = RED_COLOR.linear_interpolate(GREEN_COLOR, length / MAX_LENGTH)

	draw_line(Vector2(0, 0), target / get_scale(), color, 2.0)

func _process(delta):
	time_launched += delta
	if time_launched > 1.0 && current_box.is_sleeping():
		on_box_landed()
		set_process(false)
		set_process_input(true)

func on_box_landed():
	spawn_box()

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		end = event.global_pos
		update()
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index != BUTTON_LEFT:
			return

		if event.is_pressed():
			dragging = (event.global_pos - get_global_pos()).length_squared() < CLICK_RADIUS_SQUARED
		elif dragging:
			dragging = false
			var diff = event.global_pos - get_global_pos()
			var length = diff.length()
			if length > MAX_LENGTH:
				length = MAX_LENGTH
			var dir = -diff.normalized()
			current_box.launch(dir, MAX_SPEED * (length / MAX_LENGTH))
			set_process_input(false)
			set_process(true)
			update()

