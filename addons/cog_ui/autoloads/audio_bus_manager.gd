extends Node


signal audio_settings_changed
signal audio_settings_loaded
signal audio_settings_saved


const USER_PATH: String = "user://user_audio_settings.tres"
const DEFAULT_PATH: String = "res://default_bus_layout.tres"

var has_unsaved_changes: bool = false


func _ready():
	var file_exists: bool = ResourceLoader.exists(USER_PATH)
	
	if file_exists:
		load_user_bus_layout()
	else:
		save_user_bus_layout()


func load_default_bus_layout() -> void:
	_load_bus_layout(DEFAULT_PATH)


func load_user_bus_layout() -> void:
	_load_bus_layout(USER_PATH)


func save_user_bus_layout() -> void:
	var bus_layout: AudioBusLayout = AudioServer.generate_bus_layout()
	ResourceSaver.save(bus_layout, USER_PATH)


func _load_bus_layout(path: String) -> void:
	var file_layout: AudioBusLayout = ResourceLoader.load(path)
	AudioServer.set_bus_layout(file_layout)
	audio_settings_loaded.emit()


func set_as_unsaved() -> void:
	has_unsaved_changes = true
	audio_settings_changed.emit()


func set_as_saved() -> void:
	has_unsaved_changes = false
	audio_settings_saved.emit()
