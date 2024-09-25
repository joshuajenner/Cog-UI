class_name VolumeSlider
extends HSlider


const _WARNING: String = "This Volume Slider does not have a valid Audio Bus."

@export var audio_bus: String

var _bus_index: int = -1


func _ready() -> void:
	_bus_index = AudioServer.get_bus_index(audio_bus)
	assert(_bus_index != -1, _WARNING);

	drag_ended.connect(_on_drag_ended)
	AudioSettings.settings_loaded.connect(_on_settings_loaded)

	_setup_slider()
	_on_settings_loaded()


func _setup_slider() -> void:
	max_value = 1
	step = 0.01


func _on_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var new_volume: float = linear_to_db(value)
		AudioServer.set_bus_volume_db(_bus_index, new_volume)


func _on_settings_loaded() -> void:
	var volume: float = AudioServer.get_bus_volume_db(_bus_index)
	value = db_to_linear(volume)
