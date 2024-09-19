class_name WindowModeSelect
extends CheckButton


func _ready() -> void:
	toggled.connect(_on_toggled)
	VideoSettings.settings_loaded.connect(_on_settings_loaded)


func _on_toggled(toggled_on: bool) -> void:
	VideoSettings.set_is_fullscreen(toggled_on)


func _on_settings_loaded() -> void:
	button_pressed = VideoSettings.is_fullscreen
