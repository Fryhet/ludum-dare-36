extends Node2D

export(PackedScene) var box_scene
export(Color) var weak_color
export(Color) var strong_color

const MAX_SPEED = 100.0
const CLICK_RADIUS = 100.0
const CLICK_RADIUS_SQUARED = CLICK_RADIUS * CLICK_RADIUS
const MAX_LENGTH = 200.0
const MAX_LENGTH_SQUARED = MAX_LENGTH * MAX_LENGTH
const HINT_LENGTH = 500.0
const HINT_LENGTH_SQUARED = HINT_LENGTH * HINT_LENGTH

var dragging = false

var stats
var holder
var current_block
var wood
var front_string
var back_string

var current_box_type = global.BOX_TYPE_SAND

signal launched(block)
signal all_blocks_used

func launch(impulse):
	emit_signal("launched", current_block)
	current_block.launch(impulse)
	stats.increment_used()
	holder.set_pos(Vector2(0.0, 0.0))
	set_launched(true)

func set_launched(launched):
	get_node("../finished").set_disabled(launched)
	set_process_unhandled_input(!launched)

func _ready():
	stats = get_node("../stats")
	holder = get_node("holder")
	wood = get_node("wood")
	front_string = get_node("wood/front/string")
	back_string = get_node("wood/back/string")
	set_process_unhandled_input(true)

func respawn_box():
	if !is_processing_unhandled_input():
		return # there's no way back!
	if current_block != null:
		current_block.queue_free()
	if stats.used >= stats.max_used:
		return

	current_block = box_scene.instance()
	current_block.connect("on_landed", self, "on_block_landed")
	current_block.call_deferred("set_type", current_box_type)

	get_node("../blocks").add_child(current_block)
	current_block.set_pos(holder.get_global_pos())

func _draw():
	var pos = get_pos()
	var scale = get_scale()
	var target = holder.get_global_pos() - pos
	var length = target.length()
	var dir = -target / length
	if length > MAX_LENGTH:
		target = target / length * MAX_LENGTH
		length = MAX_LENGTH

	draw_trajectory(dir, length, scale)

	target /= scale
	draw_line((front_string.get_global_pos() - pos) / scale, target, global.COLOR_GRAY, 2.0)
	draw_line((back_string.get_global_pos() - pos) / scale, target, global.COLOR_GRAY, 2.0)

func draw_trajectory(dir, length, scale):
	# FIXME: Oh my, this is so bad. It's not even too accurate, although it
	# serves as a relatively good approximation.

	var fraction = length / MAX_LENGTH
	var color = weak_color.linear_interpolate(strong_color, fraction)
	var impulse = dir * MAX_SPEED * fraction

	var gravity = Vector2(0.0, 5.7) # FIXME: magic
	var pos = get_node("holder").get_pos() * scale
	var start_pos = pos
	var step = 0.2
	var t = 0.0

	while (pos - start_pos).length_squared() < HINT_LENGTH_SQUARED:
		impulse += gravity * step
		var next_pos = pos + (impulse * step)
		draw_line(pos / scale, next_pos / scale, color, 10.0)

		pos = next_pos
		t += step

func on_block_landed(block):
	assert(block == current_block)

	set_launched(false)

	if block.type == global.BOX_TYPE_DESTROYER:
		block.destroy()
	current_block = null
	if stats.used >= stats.max_used:
		emit_signal("all_blocks_used")
	else:
		respawn_box()

func _unhandled_input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		if !dragging:
			return
		var pos = wood.get_global_pos()
		var diff = event.pos - pos
		var length = diff.length()
		if length > MAX_LENGTH:
			diff = diff / length * MAX_LENGTH
			length = MAX_LENGTH
		pos += diff
		holder.set_global_pos(pos)
		current_block.set_pos(pos)
		update()
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index != BUTTON_LEFT || current_block == null:
			return

		if event.is_pressed():
			dragging = (event.pos - get_global_pos()).length_squared() < CLICK_RADIUS_SQUARED
		elif dragging:
			dragging = false
			var diff = event.pos - get_global_pos()
			var length = diff.length()
			if length > MAX_LENGTH:
				length = MAX_LENGTH
			var dir = -diff.normalized()

			launch(dir * calculate_impulse_strength(length))
			update()

func calculate_impulse_strength(length):
	return MAX_SPEED * (length / MAX_LENGTH) * current_block.get_weight()
