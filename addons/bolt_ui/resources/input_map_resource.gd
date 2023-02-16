class_name InputMapResource
extends Resource


@export var input_map = {}


func _ready():
	pass


func init_input_map():
	var project_settings_input_map = InputMap.get_actions()
	for action in project_settings_input_map:
		input_map[action] = InputMap.action_get_events(action)
