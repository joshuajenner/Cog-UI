extends Control


@onready var save = %Save
@onready var cancel = %Cancel
@onready var reset = %Reset


func _ready():
	AudioBusManager.connect("audio_settings_saved", disable_buttons)
	AudioBusManager.connect("audio_settings_changed", enable_buttons)
	AudioBusManager.connect("audio_settings_loaded", enable_buttons)
	disable_buttons()


func disable_buttons():
	save.disabled = true
	cancel.disabled = true


func enable_buttons():
	save.disabled = false
	cancel.disabled = false


func _on_save_pressed():
	AudioBusManager.save_user_bus_layout()
	AudioBusManager.set_as_saved()


func _on_cancel_pressed():
	AudioBusManager.load_user_bus_layout()
	AudioBusManager.set_as_saved()


func _on_reset_pressed():
	AudioBusManager.load_default_bus_layout()
	AudioBusManager.set_as_unsaved()
