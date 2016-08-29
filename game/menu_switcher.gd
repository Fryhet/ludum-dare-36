extends Control

func switch_menu(menu):
	get_child(0).queue_free()
	add_child(menu.instance())
