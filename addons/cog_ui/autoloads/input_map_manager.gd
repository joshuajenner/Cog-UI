extends Node


@export var key_labels: KeyLabels
@export var mouse_button_labels: MouseButtonLabels
@export var joy_button_labels: JoyButtonLabels

const USER_INPUT_MAP: String = "user://user_input_map.tres"
const DEFAULT_INPUT_MAP: String = "res://default_input_map.tres"


func _ready():
	save_default_input_map()
	var file_exists: bool = ResourceLoader.exists(USER_INPUT_MAP)
	
	if file_exists:
		load_user_input_map()
	else:
		save_user_input_map()


func save_default_input_map() -> void:
	_save_input_map(DEFAULT_INPUT_MAP)


func load_default_input_map() -> void:
	_load_input_map(DEFAULT_INPUT_MAP)


func load_user_input_map() -> void:
	_load_input_map(USER_INPUT_MAP)


func save_user_input_map() -> void:
	_save_input_map(USER_INPUT_MAP)


func get_key_label(keycode: int) -> String:
	if key_labels != null:
		return key_labels.get_label(keycode)
	else:
		return ""


func get_mouse_label(mouse_index: int) -> String:
	if mouse_button_labels != null:
		return mouse_button_labels.get_label(mouse_index)
	else:
		return ""


func get_joypad_label(joypad_index: int) -> String:
	if joy_button_labels != null:
		return joy_button_labels.get_label(joypad_index)
	else:
		return ""


func _save_input_map(path: String) -> void:
	var input_resource: InputMapResource = InputMapResource.new()
	ResourceSaver.save(input_resource, path)


func _load_input_map(path: String) -> void:
	var resource: InputMapResource = ResourceLoader.load(path)
	var user_map: Dictionary = resource.input_map
	var game_map: Array[StringName] = InputMap.get_actions()
	
	for action in game_map:
		if (user_map.has(action)):
			InputMap.action_erase_events(action)
			
			for event in user_map[action]:
				InputMap.action_add_event(action, event)
