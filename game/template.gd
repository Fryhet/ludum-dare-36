tool
extends Node2D

export(Texture) var box_texture

func _draw():
	draw_texture(box_texture, Vector2(0, 0))
