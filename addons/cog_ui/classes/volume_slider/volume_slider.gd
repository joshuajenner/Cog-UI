@tool
class_name VolumeSlider
extends HSlider

const WARNING: String = "This VolumeSlider does not have a valid Audio Bus."

var audio_bus: String:
	set = _on_audio_bus_changed

var bus_index: int = -1


func _ready() -> void:
	set_bus_index()
	assert(bus_index != -1, WARNING);
	
	AudioBusManager.audio_settings_loaded.connect(set_volume_from_bus)
	drag_ended.connect(_on_drag_ended)
	setup_slider()
	set_volume_from_bus()


func setup_slider() -> void:
	max_value = 1
	step = 0.01


func _get_property_list() -> Array:
	set_bus_index()
	return [
		{
			name = "audio_bus",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(get_audio_buses())
		},
	]


func get_audio_buses() -> Array[String]:
	var bus_count: int = AudioServer.bus_count
	var buses: Array[String] = []
	for index in bus_count:
		buses.push_back(AudioServer.get_bus_name(index))
	return buses


func set_volume_from_bus() -> void:
	var volume: float = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(volume)


func _on_drag_ended(_value_changed) -> void:
	var new_volume: float = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, new_volume)
	AudioBusManager.set_as_unsaved()


func _on_audio_bus_changed(value) -> void:
	audio_bus = value
	set_bus_index()


func set_bus_index():
	bus_index = AudioServer.get_bus_index(audio_bus)
	update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	if bus_index == -1:
		return PackedStringArray([WARNING])
	else:
		return PackedStringArray()
