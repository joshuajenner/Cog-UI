extends Control

@onready var audio_tab = %AudioTab
@onready var control_tab = %ControlTab

@onready var audio_section = %AudioSection
@onready var controls_section = %ControlsSection

@onready var sections: Array[Dictionary] = [
	{"index": 0, "tab": audio_tab, "content": audio_section},
	{"index": 1, "tab": control_tab, "content": controls_section}
]

var current_tab: int = 0

func _ready():
	select_section(current_tab)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://examples/main_menu/main_menu.tscn")


func _input(event: InputEvent):
	if event.is_action_pressed("ui_next_section"):
		select_section(current_tab + 1)
	elif event.is_action_pressed("ui_prev_section"):
		select_section(current_tab - 1)


#func move_section(direction: int) -> void:
	#var check_index: int = current_tab + direction
	#
		#select_section(check_index)


func select_section(index: int) -> void:
	if index < sections.size() and index >= 0:
		current_tab = index
		for section in sections:
			if section.index == index:
				section.tab.button_pressed = true
				section.content.visible = true
			else:
				section.tab.button_pressed = false
				section.content.visible = false
