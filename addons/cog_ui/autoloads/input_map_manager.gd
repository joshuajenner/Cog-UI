extends Node

const INPUT_FILE_PATH : String = "user://user_input_map.tres"


func _ready():
	var file_exists : bool = ResourceLoader.exists(INPUT_FILE_PATH)
	
	if file_exists:
		load_resource_to_input_map()
	else:
		save_input_map_to_resource()


func load_resource_to_input_map() -> void:
	var resource : InputMapResource = ResourceLoader.load(INPUT_FILE_PATH)
	var user_map : Dictionary = resource.input_map
	var game_map : Array[StringName] = InputMap.get_actions()
	
	for action in game_map:
		InputMap.action_erase_events(action)
		
		for event in user_map[action]:
			InputMap.action_add_event(action, event)


func save_input_map_to_resource() -> void:
	var input_resource : InputMapResource = InputMapResource.new()
	ResourceSaver.save(input_resource, INPUT_FILE_PATH)
