@tool
class_name VolumeSlider
extends Slider

## Attach to an HSlider or VSlider to automatically adjust the volume of 
## the selected Audio Bus on drag.

const WARNING: String = "This Volume Slider does not have a valid Audio Bus."

## Select which Audio Bus to edit.
var audio_bus: String:
	set = _on_audio_bus_changed

var _bus_index: int = -1


func _ready() -> void:
	_set_bus_index()
	assert(_bus_index != -1, WARNING);
	
	AudioBusManager.bus_layout_loaded.connect(_set_volume_from_bus)
	drag_ended.connect(_on_drag_ended)
	_setup_slider()
	_set_volume_from_bus()


func _set_bus_index() -> void:
	_bus_index = AudioServer.get_bus_index(audio_bus)
	update_configuration_warnings()


func _setup_slider() -> void:
	max_value = 1
	step = 0.01


func _set_volume_from_bus() -> void:
	var volume: float = AudioServer.get_bus_volume_db(_bus_index)
	value = db_to_linear(volume)


func _on_drag_ended(_value_changed) -> void:
	var new_volume: float = linear_to_db(value)
	AudioServer.set_bus_volume_db(_bus_index, new_volume)
	AudioBusManager.bus_layout_changed.emit()


func _on_audio_bus_changed(value) -> void:
	audio_bus = value
	_set_bus_index()


func _get_property_list() -> Array:
	_set_bus_index()
	return [
		{
			name = "audio_bus",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(_get_audio_buses())
		},
	]


func _get_audio_buses() -> Array[String]:
	var bus_count: int = AudioServer.bus_count
	var buses: Array[String] = []
	for index in bus_count:
		buses.push_back(AudioServer.get_bus_name(index))
	return buses


func _get_configuration_warnings() -> PackedStringArray:
	if _bus_index == -1:
		return PackedStringArray([WARNING])
	else:
		return PackedStringArray()
