extends MarginContainer



#func _ready():
		#AudioBusManager.connect("bus_layout_saved", disable_buttons)
		#AudioBusManager.connect("bus_layout_changed", enable_buttons)
		#AudioBusManager.connect("bus_layout_loaded", enable_buttons)
#
#
#func _on_save_pressed():
	#AudioBusManager.save_user_bus_layout()
#
#
#func _on_cancel_pressed():
	#AudioBusManager.load_user_bus_layout()
	#AudioBusManager.audio_settings_saved.emit()
#
#
#func _on_reset_pressed():
	#AudioBusManager.load_default_bus_layout()
