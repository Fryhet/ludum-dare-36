extends Control

var precision
var blocks
var max_blocks

func set_shape_precision(precision):
	self.precision = precision
	get_node("panel/container/precision").set_text(str(tr("PRECISION"), ": ", "%.2f%%" % (precision * 100.0)))

func set_blocks_used(blocks, max_blocks):
	self.blocks = blocks
	self.max_blocks = max_blocks
	get_node("panel/container/blocks_used").set_text(str(tr("BLOCKS_USED"), ": ", blocks, "/", max_blocks))

func generate_verdict():
	get_node("panel/verdict").set_text(str('"', tr(precision_verdict(precision)), '"'))

func precision_verdict(score):
	if global.template_to_load == 0:
		if score > 0.40:
			return "VERDICT_GOOD_FIRST_LEVEL"
		return "VERDICT_BAD_FIRST_LEVEL"
	
	if score > 0.95:
		return "VERDICT_95_TO_100"
	if score > 0.80:
		return "VERDICT_80_TO_95"
	if score > 0.60:
		return "VERDICT_60_TO_80"
	if score > 0.40:
		return "VERDICT_40_TO_60"
	if score > 0.20:
		return "VERDICT_20_TO_40"
	return "VERDICT_0_TO_20"
