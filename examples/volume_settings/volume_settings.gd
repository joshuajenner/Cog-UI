extends Control


@onready var save = %Save
@onready var cancel = %Cancel


func _ready():
	AudioBusManager.connect("bus_layout_saved", disable_buttons)
	AudioBusManager.connect("bus_layout_changed", enable_buttons)
	AudioBusManager.connect("bus_layout_loaded", enable_buttons)
	disable_buttons()


func disable_buttons():
	save.disabled = true
	cancel.disabled = true


func enable_buttons():
	save.disabled = false
	cancel.disabled = false


func _on_save_pressed():
	AudioBusManager.save_user_bus_layout()


func _on_cancel_pressed():
	AudioBusManager.load_user_bus_layout()
	AudioBusManager.audio_settings_saved.emit()


func _on_reset_pressed():
	AudioBusManager.load_default_bus_layout()
