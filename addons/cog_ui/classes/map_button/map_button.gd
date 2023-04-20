class_name MapButton
extends Button


@export var action: String
@export var event_index: int = 0
@export var handling_assigns: bool = true

const INPUT_REQUEST: String = "Press any key"

var event_display: String = ""
var waiting_for_assign: bool = false


func _ready():
	pressed.connect(_on_pressed)
	InputMapManager.assign_completed.connect(_on_assign_completed)
	
	var event: InputEvent = get_event_from_action()
	if event != null:
		event_display = get_event_display(event)
		display_event()


func display_event_from_action() -> void:
	event_display = InputMapManager.get_display_kbm(action, event_index)
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
	if waiting_for_assign:
		if event_can_be_assigned(event):
			InputMapManager.assign_event(action, event, event_index)
		elif event.is_action("ui_cancel"):
			waiting_for_assign = false
			display_event()
		elif event.is_action_pressed("ui_text_backspace"):
			InputMapManager.unassign_event()
		


func event_can_be_assigned(event: InputEvent) -> bool:
	# Should be replaced by extender script
	return true


func display_event() -> void:
	text = event_display


func display_request() -> void:
	text = INPUT_REQUEST


func _on_assign_completed(signal_action: String) -> void:
	if action == signal_action:
		# dupe code, replace
		var event: InputEvent = get_event_from_action()
		if event != null:
			event_display = get_event_display(event)
			display_event()


func _on_pressed() -> void:
	InputMapManager.assign_requested.emit()
	if handling_assigns:
		waiting_for_assign = true
		display_request()
