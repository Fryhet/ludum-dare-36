extends Control

export(Texture) var texture
export(int, "None", "Gray", "Sand", "Destroyer") var type

func _ready():
	update()

func _draw():
	var size = get_size()
	var tex_size = texture.get_height()
	var tex_pos_x = (randi() % (texture.get_width() / tex_size)) * tex_size

	var center = size / 2.0
	var min_size = min(size.x, size.y)
	size.x = min_size
	size.y = min_size

	var rect = Rect2(center - (size / 2.0), size)
	var src_rect = Rect2(tex_pos_x, 0, tex_size, tex_size)
	draw_texture_rect_region(texture, rect, src_rect, global.get_box_type_color(type))

