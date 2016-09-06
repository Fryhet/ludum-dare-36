extends Control

func _ready():
	translate()
	set_process_input(true)

func translate():
	var tab_container = get_node("tab_container")
	tab_container.set_tab_title(0, tr("THE_STORY"))
	tab_container.set_tab_title(1, tr("BLOCKS"))

	var the_story = get_node("tab_container/the_story/text")
	the_story.set_bbcode(the_story.get_bbcode()\
		.replace("STORY_0", tr("STORY_0"))\
		.replace("STORY_1", tr("STORY_1"))\
		.replace("STORY_2", tr("STORY_2"))\
		.replace("STORY_3", tr("STORY_3"))\
	)
	pass

func _input(event):
	if event.type == InputEvent.KEY && event.is_action("ui_cancel") && !event.is_pressed():
		_on_main_menu_pressed()

func _on_main_menu_pressed():
	sample_player.play("button")
	scene_switcher.switch_scene(preload("res://game/main_menu/main_menu.tscn"))
