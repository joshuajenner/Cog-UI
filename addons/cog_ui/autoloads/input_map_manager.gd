extends Node


signal edit_requested
signal edit_canceled
signal edit_completed


@export var key_labels: KeyLabels
@export var mouse_button_labels: MouseButtonLabels
@export var is_assign_inline: bool


func _ready():
	var file_exists: bool = ResourceLoader.exists(CogPaths.USER_INPUT_MAP_PATH)
	
	if file_exists:
		load_user_input_map()
	else:
		save_user_input_map()


func assign_event(action: String, new_event: InputEvent, new_event_index: int, event_type: int) -> void:
	var old_events: Array[InputEvent] = InputMap.action_get_events(action)
	var type_index: int = -1
	
	if old_events.size() == new_event_index:
		InputMap.action_add_event(action, new_event)
		
	elif old_events.size() > 0:
		for event in old_events:
			InputMap.action_erase_event(action, event)
			type_index += 1
			if new_event_index == type_index:
				InputMap.action_add_event(action, new_event)
			else:
				InputMap.action_add_event(action, event)
	else:
		InputMap.action_add_event(action, new_event)
	
	edit_completed.emit(action)


func unassign_event(action: String, event_index: int, event_type: int) -> void:
	var old_events: Array[InputEvent] = InputMap.action_get_events(action)
	var type_index: int = 0
	
	for event in old_events:
		if event_index == type_index:
			InputMap.action_erase_event(action, event)
			type_index += 1
	
	edit_completed.emit(action)


func other_action_has_event(original_action: String, check_event: InputEvent):
	var all_actions = InputMap.get_actions()
	var event_found: bool = false
	
	for action in all_actions:
		if action != original_action:
			if InputMap.action_has_event(action, check_event):
				event_found = true
				
	return event_found


func get_event_display(display_event: InputEvent) -> String:
	#old params -> action: String, event_index: int, event_type: int
#	var display_event: InputEvent = get_event_from_action(action, event_index, event_type)
	var custom_label: String = ""
	
	if display_event is InputEventKey:
		var event_keycode: int
		var event_as_text: String
		
		if display_event.physical_keycode != 0:
			event_keycode = display_event.physical_keycode
			event_as_text = display_event.as_text_physical_keycode()
		elif display_event.keycode != 0:
			event_keycode = display_event.keycode
			event_as_text = display_event.as_text_keycode()
			
		custom_label = _get_key_label(event_keycode)
		if custom_label != "":
			return custom_label
		else:
			return event_as_text
		
	elif display_event is InputEventMouseButton:
		custom_label = _get_mouse_label(display_event.button_index)
		if custom_label != "":
			return custom_label
		else:
			return display_event.as_text()
		
	return ""


func get_event_from_action(action: String, event_index: int, event_type: int) -> InputEvent:
	var action_events: Array[InputEvent] = InputMap.action_get_events(action)
	var current_index: int = 0
	
	for event in action_events:
		if current_index == event_index:
			return event
		else:
			current_index += 1
	
	return null


func _get_key_label(keycode: int) -> String:
	if key_labels != null:
		return key_labels.get_label(keycode)
	else:
		return ""


func _get_mouse_label(mouse_index: int) -> String:
	if mouse_button_labels != null:
		return mouse_button_labels.get_label(mouse_index)
	else:
		return ""


func load_default_input_map() -> void:
	InputMap.load_from_project_settings()


func save_user_input_map() -> void:
	var input_resource: InputMapResource = InputMapResource.new()
	ResourceSaver.save(input_resource, CogPaths.USER_INPUT_MAP_PATH)


func load_user_input_map() -> void:
	var resource: InputMapResource = ResourceLoader.load(CogPaths.USER_INPUT_MAP_PATH)
	var user_map: Dictionary = resource.input_map
	var game_map: Array[StringName] = InputMap.get_actions()
	
	for action in game_map:
		if (user_map.has(action)):
			InputMap.action_erase_events(action)
			
			for event in user_map[action]:
				InputMap.action_add_event(action, event)
