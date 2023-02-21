extends Button
class_name InputMapButton


@export var action : String
@export var key_index : int = 0

const INPUT_REQUEST : String = "Press any key"

var key_label : String = ""
var waiting_for_assign : bool = false


func _ready():
	if InputMap.has_action(action):
		get_inputs_from_action()
	else:
		disabled = true


func get_inputs_from_action():
	var keys = InputMap.action_get_events(action)
	if keys.size() >= 1:
		key_label = keys[key_index].as_text_keycode()
		disabled = false
	
	text = key_label

func _input(event):
	if waiting_for_assign:
		if event is InputEventKey and event.is_pressed():
			var key_code = event.as_text_keycode()
			assign_key_to_action(event)
			text = key_code
			release_focus()


func assign_key_to_action(event: InputEvent):
	var assigned_keys = InputMap.action_get_events(action)
	if assigned_keys.size() <= key_index:
		InputMap.action_add_event(action, event)
	else:
		InputMap.action_erase_events(action)
		for key in range(0, assigned_keys.size()-1):
			if key != key_index:
				InputMap.action_add_event(action, assigned_keys[key])
			else:
				InputMap.action_add_event(action, event)
		
	waiting_for_assign = false


func _on_pressed():
	text = INPUT_REQUEST
	waiting_for_assign = true
