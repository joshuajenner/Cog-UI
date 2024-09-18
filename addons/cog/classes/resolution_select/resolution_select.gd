class_name ResolutionSelect
extends OptionButton


@export var video_settings: VideoSettings


func _ready():
	setup()
	item_selected.connect(_on_selected)


func setup() -> void:
	var selected_res: int = video_settings.get_resolution_index()
	var resolutions: Array[Vector2i] = video_settings.get_resolutions()
	for res in resolutions:
		add_item(res_string(res))
	selected = selected_res


func res_string(vec: Vector2i) -> String:
	var format: String = "%s x %s"
	return format % [vec.x, vec.y]


func _on_selected(index: int) -> void:
	video_settings.set_resolution_by_index(index)