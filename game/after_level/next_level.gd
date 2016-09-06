extends Button

func _ready():
	set_disabled(!global.scored_enough(global.shape_precision))
