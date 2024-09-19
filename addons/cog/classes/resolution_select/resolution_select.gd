class_name ResolutionSelect
extends OptionButton


func _ready():
	item_selected.connect(_on_selected)
	VideoSettings.settings_loaded.connect(_on_settings_loaded)


func res_string(vec: Vector2i) -> String:
	var format: String = "%s x %s"
	return format % [vec.x, vec.y]


func _on_selected(index: int) -> void:
	VideoSettings.set_resolution_by_index(index)


func _on_settings_loaded() -> void:
	var selected_res: int = VideoSettings.get_resolution_index()
	var resolutions: Array[Vector2i] = VideoSettings.get_resolutions()
	for res in resolutions:
		add_item(res_string(res))
	selected = selected_res
