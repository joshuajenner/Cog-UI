class_name MapButton
extends Button


@export var action: String
@export var event_index: int = 0
@export var handling_assigns: bool = true

@export var cancel_assign_action: String = "ui_cancel"
@export var clear_event_action: String = "ui_text_backspace"

const INPUT_REQUEST: String = "Press any key"

var event_display: String = ""
var waiting_for_assign: bool = false


func _ready():
	pressed.connect(_on_pressed)
	InputMapManager.assign_completed.connect(_on_assign_completed)
	
	display_event_from_action()


func display_event_from_action() -> void:
	event_display = InputMapManager.get_event_display(action, event_index, InputMapManager.EVENT_GROUP.KBM)
	text = event_display


func get_event_from_action() -> InputEvent:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	if events.size() > event_index:
		return events[event_index]
	else:
		return null


func get_event_display(event: InputEvent) -> String:
	return event.as_text()


func _input(event: InputEvent) -> void:
	if handling_assigns and waiting_for_assign:
		if event.is_action(cancel_assign_action):
			waiting_for_assign = false
			display_event()
		elif event.is_action_pressed(clear_event_action):
			InputMapManager.unassign_event(action, event_index)
			waiting_for_assign = false
			display_event()
		elif event_can_be_assigned(event):
			InputMapManager.assign_event(action, event, event_index)
			waiting_for_assign = false


func event_can_be_assigned(event: InputEvent) -> bool:
	# Should be replaced by extender script
	return true


func display_event() -> void:
	text = event_display


func display_request() -> void:
	text = INPUT_REQUEST


func _on_assign_completed(signal_action: String) -> void:
	if action == signal_action:
		event_display = InputMapManager.get_event_display(action, event_index, InputMapManager.EVENT_GROUP.KBM)
		display_event()


func _on_pressed() -> void:
	InputMapManager.assign_requested.emit()
	if handling_assigns:
		waiting_for_assign = true
		display_request()
