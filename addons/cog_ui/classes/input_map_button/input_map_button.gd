class_name InputMapButton
extends Button


@export var action: String
@export var event_index: int = 0
@export_enum("Default", "Signal") var assign_behaviour: int

@export var cancel_assign_key: String = "ui_cancel"
@export var clear_event_key: String = "ui_text_backspace"

const INPUT_REQUEST: String = "Press any key"

var event: InputEvent = null
var event_display: String = ""
var waiting_for_assign: bool = false


enum BEHAVIOUR {
	DEFAULT,
	SIGNAL
}

func _ready():
	pressed.connect(_on_pressed)
	InputMapManager.edit_completed.connect(_on_edit_completed)
	
	event = InputMapManager.get_event_from_action(action, event_index, InputMapManager.EVENT_GROUP.KBM)
	event_display = InputMapManager.get_event_display(event)
	
	display_event()
	# get_event_from_action
	# get_display_from_event
	# display_event()


#func display_event_from_action() -> void:
#	event_display = InputMapManager.get_event_display(action, event_index, InputMapManager.EVENT_GROUP.KBM)
#	text = event_display

#func get_event_from_action() -> InputEvent:
#	var events: Array[InputEvent] = InputMap.action_get_events(action)
#	if events.size() > event_index:
#		return events[event_index]
#	else:
#		return null

func get_event_display(event: InputEvent) -> String:
	return event.as_text()


func _input(event: InputEvent) -> void:
	if InputMapManager.is_handling_assigns and waiting_for_assign:
		if event.is_action_pressed(cancel_assign_key):
			waiting_for_assign = false
			InputMapManager.edit_canceled.emit(action)
			display_event()
		elif event.is_action_pressed(clear_event_key):
			InputMapManager.unassign_event(action, event_index, InputMapManager.EVENT_GROUP.KBM)
			waiting_for_assign = false
			display_event()
		elif event.is_pressed():
			InputMapManager.assign_event(action, event, event_index, InputMapManager.EVENT_GROUP.KBM)
			waiting_for_assign = false
			get_viewport().set_input_as_handled()


func display_event() -> void:
	text = event_display


func display_request() -> void:
	text = INPUT_REQUEST


func _on_edit_completed(signal_action: String) -> void:
	if action == signal_action:
		event = InputMapManager.get_event_from_action(action, event_index, InputMapManager.EVENT_GROUP.KBM)
		event_display = InputMapManager.get_event_display(event)
		display_event()


func _on_pressed() -> void:
	InputMapManager.edit_requested.emit()
	if assign_behaviour == BEHAVIOUR.SIGNAL:
		waiting_for_assign = true
		display_request()
