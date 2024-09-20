class_name WindowModeSelect
extends OptionButton


func _ready() -> void:
	item_selected.connect(_on_selected)
	VideoSettings.settings_loaded.connect(_on_settings_loaded)


func _on_selected(index: int) -> void:
	VideoSettings.set_window_mode(index)


func _on_settings_loaded() -> void:
	pass
