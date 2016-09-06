extends Sprite

func reload_texture(type):
	set_rotd(90 * (randi() % 4))
	if type == global.BOX_TYPE_DESTROYER:
		set_texture(preload("res://assets/destroyer.png"))
		set_region(false)
	else:
		set_texture(preload("res://assets/block.png"))
		set_region(true)
		var rect = get_region_rect()
		rect.pos.x = (randi() % (get_texture().get_width() / int(rect.size.x))) * rect.size.x
		set_region_rect(rect)
	set_modulate(global.get_box_type_color(type))
