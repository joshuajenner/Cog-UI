@tool
class_name VolumeSlider
extends HSlider

var audio_bus : String :
	set = _on_audio_bus_changed

var bus_index : int = 0


func _ready() -> void:
	setup_slider()
	bus_index = AudioServer.get_bus_index(audio_bus)
	if bus_index != -1:
		get_volume_from_bus()

func setup_slider() -> void:
	max_value = 1
	step = 0.01


func _get_property_list() -> Array:
	bus_index = AudioServer.get_bus_index(audio_bus)
	update_configuration_warnings()
	return [
		{
			name = "audio_bus",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(get_audio_buses())
		},
	]


func get_audio_buses() -> Array[String]:
	var bus_count : int = AudioServer.bus_count
	var buses : Array[String] = []
	for index in bus_count:
		buses.push_back(AudioServer.get_bus_name(index))
	return buses



func get_volume_from_bus() -> void:
	var volume : float = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(volume)
	print(value)


func _on_drag_ended(value_changed) -> void:
	var new_volume : float = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, new_volume)


func _on_audio_bus_changed(value) -> void:
	audio_bus = value
	bus_index = AudioServer.get_bus_index(audio_bus)
	update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	if bus_index == -1:
		return PackedStringArray(["The Audio Bus was not found."])
	else:
		return PackedStringArray()
