class_name WindowModeSelect
extends CheckButton


func _ready() -> void:
	toggled.connect(_on_toggled)
	button_pressed = Cog.video.is_fullscreen



func _on_toggled(toggled_on: bool) -> void:
	Cog.video.apply_is_fullscreen(toggled_on)
