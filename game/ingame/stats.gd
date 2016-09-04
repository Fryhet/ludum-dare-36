extends Panel

export(Color) var bad_color
export(Color) var good_color
export(ColorRamp) var color_ramp

var precision = 0.0
var used = 0
var max_used

var precision_label
var used_label

func _ready():
	precision_label = get_node("precision")
	used_label = get_node("used")

func set_max_used(value):
	max_used = value

func increment_used():
	used += 1
	refresh_text()

func set_precision(precision):
	self.precision = precision
	refresh_text()

func refresh_text():
	if used >= max_used:
		used_label.set("custom_colors/font_color", bad_color)
	else:
		used_label.set("custom_colors/font_color", good_color)
	used_label.set_text(str("Used: ", used, "/", max_used))

	precision_label.set("custom_colors/font_color", color_ramp.interpolate(precision))
	precision_label.set_text("Precision: %.2f%%" % (precision * 100.0))
