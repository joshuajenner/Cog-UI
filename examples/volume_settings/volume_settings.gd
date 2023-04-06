extends Control


@onready var save = %Save
@onready var cancel = %Cancel
@onready var reset = %Reset


func _ready():
	AudioBusManager.connect("audio_settings_changed", _on_settings_changed)
	disable_buttons()


func disable_buttons():
	save.disabled = true
	cancel.disabled = true


func _on_settings_changed():
	save.disabled = false
	cancel.disabled = false


func _on_save_pressed():
	AudioBusManager.save_bus_layout_to_file()
	AudioBusManager.set_as_saved()
	disable_buttons()


func _on_cancel_pressed():
	AudioBusManager.load_file_to_bus_layout()
	AudioBusManager.set_as_saved()
	disable_buttons()


func _on_reset_pressed():
	AudioBusManager.load_default_bus_layout()
	AudioBusManager.set_as_unsaved()
