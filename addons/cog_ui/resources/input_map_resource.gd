class_name InputMapResource
extends Resource


@export var input_map : Dictionary = {}


func _init():
	var project_settings_input_map : Array[StringName] = InputMap.get_actions()
	for action in project_settings_input_map:
		input_map[action] = InputMap.action_get_events(action)
