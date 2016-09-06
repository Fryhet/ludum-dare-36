extends TextureFrame

export(Texture) var bad_texture
export(Color) var bad_color

export(Texture) var good_texture
export(Color) var good_color

func refresh(precision):
	if global.scored_enough(precision):
		set_texture(good_texture)
		set_modulate(good_color)
	else:
		set_texture(bad_texture)
		set_modulate(bad_color)
