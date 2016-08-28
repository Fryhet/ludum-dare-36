extends Container

export(Color) var bad_color
export(Color) var good_color

var used = 0
var max_used

var used_label

func _ready():
	used_label = get_node("used")

func set_max_used(value):
	max_used = value

func increment_used():
	used += 1
	refresh_text()

func refresh_text():
	if used >= max_used:
		used_label.set("custom_colors/font_color", bad_color)
	else:
		used_label.set("custom_colors/font_color", good_color)
	used_label.set_text(str("Used: ", used, "/", max_used))
	