extends Node

var template
var stats

var template_id
var game_mode

func _ready():
	template_id = scene_switcher.get_arg("template_id")
	game_mode = scene_switcher.get_arg("game_mode")

	var background_scene = load(str("res://game/backgrounds/background_", randi() % global.BACKGROUND_COUNT, ".tscn"))
	var background = background_scene.instance()
	get_node("background").add_child(background)
	background.get_node("animation_player").seek(get_node("/root/main/day_night").get_current_animation_time())

	var template_scene = load(str("res://game/templates/template_", template_id, ".tscn"))
	template = template_scene.instance()
	get_node("template").add_child(template)
	stats = get_node("stats")
	stats.set_max_used(template.max_blocks)
	stats.refresh_text()
	get_node("slingshot").respawn_box()

	set_fixed_process(true)

func _fixed_process(delta):
	stats.set_precision(template.check_shape_precision())

func _on_finished_pressed():
	sample_player.play("button")

	var args = {
		"template_id": template_id,
		"precision": get_node("template/template").check_shape_precision(),
		"blocks_used": stats.used,
		"max_blocks_used": stats.max_used,
		"game_mode": game_mode
	}
	if game_mode == global.GAME_MODE_NORMAL:
		if template_id >= global.TEMPLATE_COUNT - 1:
			scene_switcher.switch_scene(load("res://game/after_level/after_level_end.tscn"), args)
		else:
			scene_switcher.switch_scene(load("res://game/after_level/after_level_normal.tscn"), args)
	elif game_mode == global.GAME_MODE_SELECT:
		scene_switcher.switch_scene(load("res://game/after_level/after_level_select.tscn"), args)
