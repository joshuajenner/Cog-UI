extends Node

const INPUT_FILE_PATH : String = "user://user_input_map.tres"


func _ready():
	load_resource_file()


func load_resource_file() -> void:
	var file_exists : bool = ResourceLoader.exists(INPUT_FILE_PATH)
	
	if file_exists:
		var file : InputMapResource = ResourceLoader.load(INPUT_FILE_PATH)
		load_resource_to_settings(file)
	else:
		save_settings_to_resource()


func load_resource_to_settings(file : InputMapResource) -> void:
	var actions_map : Array[StringName] = InputMap.get_actions()
	var file_input_map : Dictionary = file.input_map
	
	for action in actions_map:
		InputMap.action_erase_events(action)
		
		for key in file_input_map[action]:
			InputMap.action_add_event(action, key)


func save_settings_to_resource() -> void:
	var input_resource = InputMapResource.new()
	input_resource.load_input_map()
	ResourceSaver.save(input_resource, INPUT_FILE_PATH)
