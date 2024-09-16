class_name CogInput
extends Node


const INPUT_SECTION: String = "Input"


func _ready() -> void:
	load_disk_to_input_map()


func load_disk_to_input_map() -> void:
	var config: ConfigFile = ConfigFile.new()
	var load_status: Error = config.load(CogPaths.USER_INPUT_CONFIG_PATH)

	if load_status == OK:
		load_config_to_input_map(config) 


func save_input_map_to_disk() -> void:
	var config = ConfigFile.new()
	var all_actions: Array[StringName] = InputMap.get_actions()

	for action: StringName in all_actions:
		config.set_value(INPUT_SECTION, action, InputMap.action_get_events(action))

	config.save(CogPaths.USER_INPUT_CONFIG_PATH)


func load_config_to_input_map(config: ConfigFile) -> void:
	var keys: PackedStringArray = config.get_section_keys(INPUT_SECTION)

	for key in keys:
		var events: Array[InputEvent] = config.get_value(INPUT_SECTION, key)
		InputMap.action_erase_events(key)

		for event in events:
			InputMap.action_add_event(key, event)
