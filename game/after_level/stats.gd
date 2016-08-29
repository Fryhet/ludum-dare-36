extends Control

var precision
var blocks
var max_blocks

func set_shape_precision(precision):
	self.precision = precision
	get_node("panel/container/shape_precision").set_text(str("Shape precision: ", to_percent_string(precision)))

func set_blocks_used(blocks, max_blocks):
	self.blocks = blocks
	self.max_blocks = max_blocks
	get_node("panel/container/blocks_used").set_text(str("Blocks used: ", blocks, "/", max_blocks))

func generate_verdict():
	get_node("panel/verdict").set_text(str('"', precision_verdict(precision), block_verdict(blocks, max_blocks), '"'))

func precision_verdict(score):
	if global.template_to_load == 0:
		if score > 0.50:
			return "Good job, now onto something bigger!"
		return "Come on, you can do better!"
	
	if score > 0.95:
		return "Great, this is exacly what I wanted!"
	if score > 0.80:
		return "Nice, great job!"
	if score > 0.60:
		return "Yeah, it's quite good!"
	if score > 0.40:
		return "Not too bad."
	if score > 0.20:
		return "Come on, you can do better!"
	return "What is this?! Do you want to move these rocks by hand?"

func block_verdict(blocks, max_blocks):
	if blocks > max_blocks:
		return " Also, don't use so much blocks! We're trying to be efficient here!"
	return ""

func to_percent_string(score):
	return "%.2f%%" % (score * 100.0)
