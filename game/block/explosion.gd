extends Node2D

var particles

func start(position, color):
	particles = get_node("particles")
	set_global_pos(position)
	particles.set_color(color)
	particles.set_emitting(true)
	set_process(true)

func _process(delta):
	if !particles.is_processing():
		queue_free()
		print("Puff")

