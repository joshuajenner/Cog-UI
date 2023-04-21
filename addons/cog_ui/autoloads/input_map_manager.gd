extends Node

signal assign_requested
signal assign_completed

@export var key_labels: KeyLabels
@export var mouse_button_labels: MouseButtonLabels

const USER_INPUT_MAP: String = "user://user_input_map.tres"
const DEFAULT_INPUT_MAP: String = "res://default_input_map.tres"


func _ready():
	save_default_input_map()
	var file_exists: bool = ResourceLoader.exists(USER_INPUT_MAP)
	
	if file_exists:
		load_user_input_map()
	else:
		save_user_input_map()


func assign_event(action: String, new_event: InputEvent, event_index: int) -> void:
	var old_events: Array[InputEvent] = InputMap.action_get_events(action)
	
	if old_events.size() <= event_index:
		InputMap.action_add_event(action, new_event)
	else:
		InputMap.action_erase_events(action)
		for event in range(0, old_events.size()):
			if event != event_index:
				InputMap.action_add_event(action, old_events[event])
			else:
				InputMap.action_add_event(action, new_event)
	
	assign_completed.emit(action)


func unassign_event() -> void:
	pass

func action_has_event

func get_event_display_kbm(action: String, event_index: int) -> String:
	var display_event: InputEvent = get_event_from_action_kbm(action, event_index)
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
			
		custom_label = get_key_label(event_keycode)
		if custom_label != "":
			return custom_label
		else:
			return event_as_text
		
	elif display_event is InputEventMouseButton:
		custom_label = get_mouse_label(display_event.button_index)
		if custom_label != "":
			return custom_label
		else:
			return display_event.as_text()
		
	return ""


func get_event_from_action_kbm(action: String, event_index: int):
	var action_events: Array[InputEvent] = InputMap.action_get_events(action)
	var current_index = 0
	
	for event in action_events:
		if event is InputEventKey or event is InputEventMouseButton:
			if current_index == event_index:
				return event
			else:
				current_index += 1
	
	return null


func get_event_display_joypad(action: String, event_index: int) -> String:
	return ""


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
