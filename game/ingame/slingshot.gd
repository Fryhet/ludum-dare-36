extends Node2D

export(PackedScene) var box_scene

const MAX_SPEED = 1000.0
const CLICK_RADIUS = 100.0
const CLICK_RADIUS_SQUARED = CLICK_RADIUS * CLICK_RADIUS
const MAX_LENGTH = 200.0
const MAX_LENGTH_SQUARED = MAX_LENGTH * MAX_LENGTH

var dragging = false
var time_launched = 0.0

var holder
var current_box
var wood
var front_string
var back_string

var current_box_type = global.BOX_TYPE_SAND

func is_launched():
	return is_processing()

func set_launched(launched):
	get_node("../finished").set_disabled(launched)
	set_process_input(!launched)
	set_process(launched)

func _ready():
	holder = get_node("holder")
	wood = get_node("wood")
	front_string = get_node("wood/front/string")
	back_string = get_node("wood/back/string")
	respawn_box()
	set_process_input(true)

func respawn_box():
	if is_launched():
		return # there's no way back!
	if current_box != null:
		current_box.queue_free()

	time_launched = 0.0
	current_box = box_scene.instance()
	current_box.set_type(current_box_type)
	#get_node("..").call_deferred("add_child", current_box)
	holder.add_child(current_box)
	current_box.set_scale(Vector2(1.0, 1.0) / get_scale())
	current_box.set_pos(Vector2(0.0, 0.0))
	current_box.set_rotd(90 * (randi() % 4))

func _draw():
	var pos = get_global_pos()
	var scale = get_scale()
	var target = holder.get_global_pos() - pos
	var length = target.length()
	if length > MAX_LENGTH:
		target = target / length * MAX_LENGTH
		length = MAX_LENGTH

	target /= scale
	draw_line((front_string.get_global_pos() - pos) / scale, target, global.COLOR_GRAY, 2.0)
	draw_line((back_string.get_global_pos() - pos) / scale, target, global.COLOR_GRAY, 2.0)

func _process(delta):
	time_launched += delta
	if time_launched > 1.0 && current_box.is_sleeping():
		set_launched(false)
		on_box_landed()

func on_box_landed():
	current_box = null
	respawn_box()

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel"):
		get_tree().change_scene("res://game/main_menu/main_menu.tscn")
		return

	if event.type == InputEvent.MOUSE_MOTION:
		if !dragging:
			return
		var pos = wood.get_global_pos()
		var diff = event.global_pos - pos
		var length = diff.length()
		if length > MAX_LENGTH:
			diff = diff / length * MAX_LENGTH
			length = MAX_LENGTH
		holder.set_global_pos(pos + diff)
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

			holder.remove_child(current_box)
			get_node("..").add_child(current_box)
			current_box.set_global_pos(holder.get_global_pos())

			current_box.launch(dir, MAX_SPEED * (length / MAX_LENGTH))
			holder.set_pos(Vector2(0.0, 0.0))
			set_launched(true)
			update()

