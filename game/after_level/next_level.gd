extends Button

func _ready():
	set_disabled(!global.scored_enough(scene_switcher.get_arg("precision")))
