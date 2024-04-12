extends Control

@onready var video_tab = %VideoTab
@onready var audio_tab = %AudioTab
@onready var control_tab = %ControlTab

@onready var video_section = %VideoSection
@onready var audio_section = %AudioSection
@onready var controls_section = %ControlsSection

@onready var sections: Array[Dictionary] = [
	{"index": 0, "tab": video_tab, "content": video_section},
	{"index": 1, "tab": audio_tab, "content": audio_section},
	{"index": 2, "tab": control_tab, "content": controls_section}
]

var current_tab: int = 0


func _ready():
	select_section(current_tab)
	Cog.audio.changed.connect(save_audio)
	Cog.controls.edit_completed.connect(save_controls)


func save_audio() -> void:
	Cog.audio.save()

func save_controls(_action: String) -> void:
	Cog.controls.save_user_input_map()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://examples/main_menu/main_menu.tscn")


func _input(event: InputEvent):
	if event.is_action_pressed("ui_next_section"):
		select_section(current_tab + 1)
	elif event.is_action_pressed("ui_prev_section"):
		select_section(current_tab - 1)


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


func _on_tab_selected(index: int) -> void:
	select_section(index)
