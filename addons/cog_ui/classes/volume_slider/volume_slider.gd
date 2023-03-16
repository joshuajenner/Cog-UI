@tool
class_name VolumeSlider
extends HSlider

@export var audio_bus : String :
	set = _on_audio_bus_changed

var bus_index : int = 0


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(audio_bus)
	if bus_index != -1:
		get_volume_from_bus()


func get_volume_from_bus() -> void:
	var volume : float = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(volume)


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
