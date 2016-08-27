tool
extends StaticBody2D

export(Texture) var texture
var shape

func _ready():
	shape = get_node("shape")

func _draw():
	var extents = shape.get_shape().get_extents() * 2.0 * shape.get_scale()
	var pos = shape.get_pos() - (extents / 2.0)
	draw_texture_rect(texture, Rect2(pos, extents), true)
