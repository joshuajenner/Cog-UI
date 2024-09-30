class_name KeyBindButton
extends Button


@export var action: String
@export var index: int
@export var wait: String
@export var cancel_action: String
@export var delete_action: String

var _is_editing: bool = false


func _ready() -> void:
	set_text_event()

	pressed.connect(_on_pressed)


func set_text_event() -> void:
	text = get_event_text()


func set_text_wait() -> void:
	text = wait


func get_event_text() -> String:
	return _get_event().as_text()


func set_wait(value: String) -> void:
	wait = value


func get_wait() -> String:
	return wait


func _input(event: InputEvent) -> void:
	if _is_editing:
		if event.is_action_pressed(cancel_action):
			_cancel_edit()
		elif event.is_action_pressed(delete_action):
			_unassign_event(event)
		else:
			_assign_event(event)


func _assign_event(event: InputEvent) -> void:
	InputSettings.assign_event(action, event, index)
	_is_editing = false
	set_text_event()


func _unassign_event(event: InputEvent) -> void:
	InputSettings.unassign_event(action, event)
	_is_editing = false
	text = ""


func _cancel_edit() -> void:
	set_text_event()
	_is_editing = false


func _get_event() -> InputEvent:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	return events[index]


func _on_pressed() -> void:
	if not _is_editing:
		set_text_wait()
		_is_editing = true
