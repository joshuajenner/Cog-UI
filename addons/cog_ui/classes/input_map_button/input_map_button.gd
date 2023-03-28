class_name InputMapButton
extends Button

@export var action : String
@export var event_index : int = 0 

const INPUT_REQUEST : String = "Press any key"

var event_label : String = ""
var waiting_for_assign : bool = false


func _ready():
	if InputMap.has_action(action):
		get_events_from_action()
		pressed.connect(_on_pressed)
	else:
		disabled = true


func get_events_from_action():
	var events : Array[InputEvent] = InputMap.action_get_events(action)
	if events.size() > event_index:
		if events[event_index].keycode == 0:
			event_label = events[event_index].as_text_physical_keycode()
		else:
			event_label = events[event_index].as_text_keycode()
		disabled = false
	elif events.size() < event_index:
		disabled = true
	
	text = event_label


func _input(event):
	if waiting_for_assign:
		if event.is_action_pressed("ui_cancel"):
			text = event_label
			waiting_for_assign = false
		elif event is InputEventKey and event.is_pressed():
			var key_code = event.as_text_keycode()
			assign_key_to_action(event)
			text = key_code
			release_focus()


func assign_key_to_action(new_event: InputEvent):
	var old_events = InputMap.action_get_events(action)
	if old_events.size() <= event_index:
		InputMap.action_add_event(action, new_event)
	else:
		InputMap.action_erase_events(action)
		for event in range(0, old_events.size()):
			if event != event_index:
				InputMap.action_add_event(action, old_events[event])
			else:
				InputMap.action_add_event(action, new_event)
		
	waiting_for_assign = false


func _on_pressed():
	text = INPUT_REQUEST
	waiting_for_assign = true
