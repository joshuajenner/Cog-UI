class_name InputMapButton
extends Button


@export var action: String
@export var event_index: int = 0


var event_display: String = ""
var waiting_for_assign: bool = false


func _ready():
	pressed.connect(_on_pressed)
	Cog.controls.edit_completed.connect(_on_edit_completed)
	
	event_display = Cog.controls.get_event_display(action, event_index)
	
	display_event()


func _input(event: InputEvent) -> void:
	if Cog.controls.is_assign_inline and waiting_for_assign:
		var cancel: String = Cog.controls.cancel_assign_action
		var clear: String = Cog.controls.clear_event_action
		if cancel != "" and event.is_action_pressed(cancel):
			waiting_for_assign = false
			Cog.controls.edit_canceled.emit(action)
			display_event()
		elif clear != "" and event.is_action_pressed(clear):
			Cog.controls.unassign_event(action, event_index)
			waiting_for_assign = false
			display_event()
		elif event.is_pressed():
			Cog.controls.assign_event(action, event, event_index)
			waiting_for_assign = false
		get_viewport().set_input_as_handled()


func display_event() -> void:
	text = event_display


func display_request() -> void:
	text = Cog.controls.assign_request_text


func _on_edit_completed(signal_action: String) -> void:
	if signal_action == "" or action == signal_action:
		event_display = Cog.controls.get_event_display(action, event_index)
		display_event()


func _on_pressed() -> void:
	Cog.controls.edit_requested.emit()
	if Cog.controls.is_assign_inline:
		waiting_for_assign = true
		display_request()
