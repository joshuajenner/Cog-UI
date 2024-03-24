extends Node


signal edit_requested
signal edit_canceled
signal edit_completed
signal duplicate_event


@export var key_labels: KeyLabels
@export var mouse_button_labels: MouseButtonLabels
@export var is_assign_inline: bool = true
@export var cancel_assign_action: String = "ui_cancel"
@export var clear_event_action: String = "ui_text_backspace"
@export var assign_request_text: String = "Press any key"


func _ready():
	var file_exists: bool = ResourceLoader.exists(CogPaths.USER_INPUT_MAP_PATH)
	
	if file_exists:
		load_user_input_map()
	else:
		save_user_input_map()


func assign_event(action: String, new_event: InputEvent, new_event_index: int) -> void:
	var old_events: Array[InputEvent] = InputMap.action_get_events(action)
	var event_index: int = 0;
	
	if old_events.size() == new_event_index:
		InputMap.action_add_event(action, new_event)
	else:
		for event in old_events:
			InputMap.action_erase_event(action, event)
			if event_index == new_event_index:
				InputMap.action_add_event(action, new_event)
			else:
				InputMap.action_add_event(action, event)
			event_index += 1
	
	if _other_action_has_event(action, new_event):
		duplicate_event.emit(action)
	
	edit_completed.emit(action)


func unassign_event(action: String, event_index: int) -> void:
	var old_events: Array[InputEvent] = InputMap.action_get_events(action)
	var index: int = 0
	
	for event in old_events:
		if event_index == index:
			InputMap.action_erase_event(action, event)
		index += 1
	
	edit_completed.emit(action)


func _other_action_has_event(original_action: String, check_event: InputEvent) -> bool:
	for action in InputMap.get_actions():
		if action != original_action:
			if InputMap.action_has_event(action, check_event):
				return true
	
	return false


func get_event_display(action: String, event_index: int) -> String:
	var event = _get_event_from_action(action, event_index)
	var custom_label: String = ""
	
	if event is InputEventKey:
		var event_keycode: int
		var event_as_text: String
		
		if event.physical_keycode != 0:
			event_keycode = event.physical_keycode
			event_as_text = event.as_text_physical_keycode()
		elif event.keycode != 0:
			event_keycode = event.keycode
			event_as_text = event.as_text_keycode()
			
		custom_label = _get_key_label(event_keycode)
		return custom_label if custom_label != "" else event_as_text
		
	elif event is InputEventMouseButton:
		custom_label = _get_mouse_label(event.button_index)
		return custom_label if custom_label != "" else event.as_text()
		
	return ""


func _get_event_from_action(action: String, event_index: int) -> InputEvent:
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
	
	edit_completed.emit("")


# Saved for joypad support later
#func _is_event_from_joypad(check_event: InputEvent) -> bool:
	#return (check_event is InputEventJoypadMotion) or (check_event is InputEventJoypadButton)
