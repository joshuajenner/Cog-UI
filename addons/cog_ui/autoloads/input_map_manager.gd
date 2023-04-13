extends Node


@export var key_labels: KeyLabels

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
