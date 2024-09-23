extends Node

signal settings_loaded

const _INDEX_KEY: String = "index"
const _MUTE_KEY: String = "mute"
const _VOLUME_KEY: String = "volume"
const _SEND_KEY: String = "send"


func _ready() -> void:
	var config: ConfigFile = ConfigFile.new()
	var load_user_settings: Error = config.load(Cog.AUDIO_SETTINGS_USER_PATH)	
	
	if load_user_settings == OK:
		_apply_config(config)
	else:
		save_user_settings()
		load_user_settings()


func load_user_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var load_settings: Error = config.load(Cog.AUDIO_SETTINGS_USER_PATH)

	if load_settings == OK:
		_apply_config(config)


func load_default_settings() -> void:
	pass


func _apply_config(config: ConfigFile) -> void:
	var sections: PackedStringArray = config.get_sections()

	for section in sections:
		var bus_index: int = config.get_value(section, _INDEX_KEY)
		AudioServer.set_bus_mute(bus_index, config.get_value(section, _MUTE_KEY))
		AudioServer.set_bus_volume_db(bus_index, config.get_value(section, _VOLUME_KEY))
		AudioServer.set_bus_send(bus_index, config.get_value(section, _SEND_KEY))


func save_user_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	
	for bus_index: int in AudioServer.bus_count:
		var bus_name: String = AudioServer.get_bus_name(bus_index)
		config.set_value(bus_name, _INDEX_KEY, bus_index)
		config.set_value(bus_name, _MUTE_KEY, AudioServer.is_bus_mute(bus_index))
		config.set_value(bus_name, _VOLUME_KEY, AudioServer.get_bus_volume_db(bus_index))
		config.set_value(bus_name, _SEND_KEY, AudioServer.get_bus_send(bus_index))
	
	config.save(Cog.AUDIO_SETTINGS_USER_PATH)
