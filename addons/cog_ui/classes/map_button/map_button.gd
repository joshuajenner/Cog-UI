class_name MapButton
extends Button


signal assign_requested
signal assign_completed


@export var action: String
@export var event_index: int = 0

const INPUT_REQUEST: String = "Press any key"

var event_display: String = ""


func _ready():
	pressed.connect(_on_pressed)
	var event: InputEvent = get_event_from_action()
	if event != null:
		event_display = get_event_display(event)
		display_event()


func get_event_from_action() -> InputEvent:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	if events.size() > event_index:
		return events[event_index]
	else:
		return null


func get_event_display(event: InputEvent) -> String:
	return event.as_text()


func display_event() -> void:
	text = event_display


func display_request() -> void:
	text = INPUT_REQUEST


func _on_pressed() -> void:
	display_request()
