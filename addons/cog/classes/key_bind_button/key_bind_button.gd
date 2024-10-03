class_name KeyBindButton
extends Button


const _WARNING: String = "This Key Bind Button does not have a valid Action."

@export var action: String
@export var index: int
@export var editing_text: String
@export var cancel_action: String
@export var delete_action: String

var _is_editing: bool = false


func _ready() -> void:
	assert(InputMap.has_action(action), _WARNING)
	set_ready()
	
	pressed.connect(_on_pressed)
	InputSettings.settings_changed.connect(_on_settings_changed)
	InputSettings.editing_text_changed.connect(_on_editing_text_changed)


func set_ready() -> void:
	text = _get_event_text()
	_is_editing = false


func set_editing() -> void:
	text = editing_text
	_is_editing = true


func _input(event: InputEvent) -> void:
	if _is_editing:
		if event.is_action_pressed(cancel_action):
			set_ready()
		elif event.is_action_pressed(delete_action):
			_unassign_event(index)
		elif _is_assignable(event):
			get_viewport().set_input_as_handled()
			_assign_event(event)


func _assign_event(event: InputEvent) -> void:
	InputSettings.assign_event(action, event, index)
	set_ready()


func _unassign_event(index: int) -> void:
	InputSettings.unassign_event(action, index)
	_is_editing = false
	set_ready()


func _is_assignable(event: InputEvent) -> bool:
	if event is InputEventMouseButton or event is InputEventKey:
		return true
	
	return false


func _get_event_text() -> String:
	var events: Array[InputEvent] = InputMap.action_get_events(action)

	if index < events.size():
		return events[index].as_text()
	
	return ""


func _on_pressed() -> void:
	if not _is_editing:
		set_editing()


func _on_settings_changed() -> void:
	set_ready()


func _on_editing_text_changed(text: String) -> void:
	editing_text = text
