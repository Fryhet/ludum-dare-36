extends Node2D

export(PackedScene) var box_scene

const BLACK_COLOR = Color(0.0, 0.0, 0.0, 1.0)

const MAX_SPEED = 1000.0
const CLICK_RADIUS = 300.0
const CLICK_RADIUS_SQUARED = CLICK_RADIUS * CLICK_RADIUS
const MAX_LENGTH = 200.0
const MAX_LENGTH_SQUARED = MAX_LENGTH * MAX_LENGTH

var dragging = false
var time_launched = 0.0

var holder
var current_box
var front_string
var back_string

func _ready():
	holder = get_node("holder")
	front_string = get_node("wood/front/string")
	back_string = get_node("wood/back/string")
	spawn_box()
	set_process_input(true)

func spawn_box():
	time_launched = 0.0
	current_box = box_scene.instance()
	#get_node("..").call_deferred("add_child", current_box)
	holder.add_child(current_box)
	current_box.set_scale(Vector2(1.0, 1.0) / get_scale())
	current_box.set_pos(Vector2(0.0, 0.0))

func _draw():
	if !dragging:
		return

	var pos = get_global_pos()
	var scale = get_scale()
	var target = holder.get_global_pos() - pos
	var length = target.length()
	if length > MAX_LENGTH:
		target = target / length * MAX_LENGTH
		length = MAX_LENGTH

	target /= scale
	draw_line((front_string.get_global_pos() - pos) / scale, target, BLACK_COLOR, 2.0)
	draw_line((back_string.get_global_pos() - pos) / scale, target, BLACK_COLOR, 2.0)

func _process(delta):
	time_launched += delta
	if time_launched > 1.0 && current_box.is_sleeping():
		on_box_landed()
		set_process(false)
		set_process_input(true)

func on_box_landed():
	spawn_box()

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel"):
		get_tree().change_scene("res://game/main_menu.tscn")
		return

	if event.type == InputEvent.MOUSE_MOTION:
		holder.set_global_pos(event.global_pos)
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
			set_process_input(false)
			set_process(true)
			update()

