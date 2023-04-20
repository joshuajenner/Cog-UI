class_name KeyMapButton
extends MapButton


#func _ready():
#	super()
#	if InputMap.has_action(action):
#		set_event_label_from_action()
#	else:
#		disabled = true

func event_can_be_assigned(event: InputEvent) -> bool:
	if event is InputEventKey or event is InputEventMouseButton and event.is_pressed():
		return true
	else:
		return false


func set_event_label_from_action():
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	if events.size() > event_index:
		set_event_label_from_event(events[event_index])
		disabled = false
	elif events.size() < event_index:
		disabled = true
	
	text = event_display


#func _input(event):
#	if waiting_for_assign:
#		if event.is_action_pressed("ui_cancel"):
#			text = event_display
#			waiting_for_assign = false
#		elif event is InputEventKey or event is InputEventMouseButton and event.is_pressed():
#			assign_event_to_action(event)
#			set_event_label_from_event(event)
#			text = event_display
#			get_viewport().set_input_as_handled()
#			release_focus()


#func assign_event_to_action(new_event: InputEvent):
#	var old_events: Array[InputEvent] = InputMap.action_get_events(action)
#	if old_events.size() <= event_index:
#		InputMap.action_add_event(action, new_event)
#	else:
#		InputMap.action_erase_events(action)
#		for event in range(0, old_events.size()):
#			if event != event_index:
#				InputMap.action_add_event(action, old_events[event])
#			else:
#				InputMap.action_add_event(action, new_event)
#
#	waiting_for_assign = false


func get_label_from_event(event: InputEvent) -> String:
	return "yup"


func set_event_label_from_event(event : InputEvent) -> void:
	var new_label: String
	
	if event is InputEventKey:
		var event_keycode: int
		var event_text: String
		
		if event.physical_keycode != 0:
			event_keycode = event.physical_keycode
			event_text = event.as_text_physical_keycode()
		elif event.keycode != 0:
			event_keycode = event.keycode
			event_text = event.as_text_keycode()
			
		new_label = InputMapManager.get_key_label(event_keycode)
		if new_label != "":
			event_display = new_label
			return
		
		event_display = event_text
		
	elif event is InputEventMouseButton:
		new_label = InputMapManager.get_mouse_label(event.button_index)
		if new_label != "":
			event_display = new_label
			return
		
		event_display = event.as_text()


#func _on_pressed():
#	if not waiting_for_assign:
#		text = INPUT_REQUEST
#		waiting_for_assign = true
