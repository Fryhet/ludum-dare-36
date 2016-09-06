extends Node2D

export(PackedScene) var box_scene

const MAX_SPEED = 100.0
const CLICK_RADIUS = 100.0
const CLICK_RADIUS_SQUARED = CLICK_RADIUS * CLICK_RADIUS
const MAX_LENGTH = 200.0
const MAX_LENGTH_SQUARED = MAX_LENGTH * MAX_LENGTH

var dragging = false

var stats
var holder
var current_block
var wood
var front_string
var back_string

var current_box_type = global.BOX_TYPE_SAND

func launch(dir, amount):
	current_block.launch(dir, amount)
	stats.increment_used()
	holder.set_pos(Vector2(0.0, 0.0))
	set_launched(true)

func set_launched(launched):
	get_node("../finished").set_disabled(launched)
	set_process_input(!launched)

func _ready():
	stats = get_node("../stats")
	holder = get_node("holder")
	wood = get_node("wood")
	front_string = get_node("wood/front/string")
	back_string = get_node("wood/back/string")
	set_process_input(true)

func respawn_box():
	if !is_processing_input():
		return # there's no way back!
	if current_block != null:
		current_block.queue_free()
	if stats.used >= stats.max_used:
		return

	current_block = box_scene.instance()
	current_block.connect("on_landed", self, "on_block_landed")
	current_block.set_type(current_box_type)
	get_node("..").call_deferred("add_child", current_block)
	current_block.set_pos(holder.get_global_pos())

func _draw():
	var pos = get_pos()
	var scale = get_scale()
	var target = holder.get_global_pos() - pos
	var length = target.length()
	if length > MAX_LENGTH:
		target = target / length * MAX_LENGTH
		length = MAX_LENGTH

	target /= scale
	draw_line((front_string.get_global_pos() - pos) / scale, target, global.COLOR_GRAY, 2.0)
	draw_line((back_string.get_global_pos() - pos) / scale, target, global.COLOR_GRAY, 2.0)

func on_block_landed(block):
	assert(block == current_block)

	set_launched(false)

	if block.type == global.BOX_TYPE_DESTROYER:
		block.destroy()
	current_block = null
	if stats.used >= stats.max_used:
		on_all_blocks_used()
	else:
		respawn_box()

func on_all_blocks_used():
	get_node("../restart").show()

func _input(event):
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

			launch(dir, MAX_SPEED * (length / MAX_LENGTH) * current_block.get_weight())
			update()

