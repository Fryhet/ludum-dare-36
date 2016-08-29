extends Node2D

var animation_player

func _ready():
	animation_player = get_node("animation_player")

func get_current_animation_time():
	return animation_player.get_current_animation_pos()
