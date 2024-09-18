class_name WindowModeSelect
extends CheckButton


@export var video_settings: VideoSettings


func _ready() -> void:
	toggled.connect(_on_toggled)
	button_pressed = video_settings.is_fullscreen


func _on_toggled(toggled_on: bool) -> void:
	video_settings.set_is_fullscreen(toggled_on)
