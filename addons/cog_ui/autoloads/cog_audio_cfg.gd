class_name CogAudioCfg
extends Node


const INDEX_KEY: String = "index"
const MUTE_KEY: String = "mute"
const VOLUME_KEY: String = "volume"
const SEND_KEY: String = "send"


func _ready() -> void:
	load_disk_to_audio_buses()


func load_disk_to_audio_buses() -> void:
	var config: ConfigFile = ConfigFile.new()
	var load_status: Error = config.load(CogPaths.BUS_LAYOUT_USER_CONFIG_PATH)

	if load_status == OK:
		load_config_to_audio_buses(config)
	else:
		save_audio_buses_to_disk()


func load_config_to_audio_buses(config: ConfigFile) -> void:
	var sections: PackedStringArray = config.get_sections()

	for section in sections:
		var bus_index: int = config.get_value(section, INDEX_KEY)
		AudioServer.set_bus_mute(bus_index, config.get_value(section, MUTE_KEY))
		AudioServer.set_bus_volume_db(bus_index, config.get_value(section, VOLUME_KEY))
		AudioServer.set_bus_send(bus_index, config.get_value(section, SEND_KEY))


func save_audio_buses_to_disk() -> void:
	var config: ConfigFile = ConfigFile.new()

	for bus_index: int in AudioServer.bus_count:
		var bus_name: String = AudioServer.get_bus_name(bus_index)
		config.set_value(bus_name, INDEX_KEY, bus_index)
		config.set_value(bus_name, MUTE_KEY, AudioServer.is_bus_mute(bus_index))
		config.set_value(bus_name, VOLUME_KEY, AudioServer.get_bus_volume_db(bus_index))
		config.set_value(bus_name, SEND_KEY, AudioServer.get_bus_send(bus_index))
	
	config.save(CogPaths.BUS_LAYOUT_USER_CONFIG_PATH)
