extends Node


signal settings_loaded

@export var window_mode: DisplayServer.WindowMode
@export var resolution: Vector2i
@export var resolutions: Array[Vector2i] = []

var window_modes: Dictionary = {
	"Fullscreen": DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	"Borderless": DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN,
	"Window": DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
}

const SECTION: String = "video_settings"
const IS_FULLSCREEN_KEY: String = "is_fullscreen"
const RESOLUTION_KEY: String = "resolution"


func _ready() -> void:
	var config: ConfigFile = ConfigFile.new()

	var load_default_settings: Error = config.load(Cog.VIDEO_SETTINGS_DEFAULT_PATH)
	if load_default_settings != OK:
		save_default_settings()

	var load_user_settings: Error = config.load(Cog.VIDEO_SETTINGS_USER_PATH)
	if load_user_settings == OK:
		load_user_settings(config)
	else:
		save_user_settings()

	settings_loaded.emit()


func load_user_settings(config: ConfigFile) -> void:
	# is_fullscreen = config.get_value(SECTION, IS_FULLSCREEN_KEY)
	resolution = config.get_value(SECTION, RESOLUTION_KEY)


func save_user_settings() -> void:
	_save_settings(Cog.VIDEO_SETTINGS_USER_PATH)	


func save_default_settings() -> void:
	_save_settings(Cog.VIDEO_SETTINGS_DEFAULT_PATH)


func _save_settings(path: String) -> void:
	var config: ConfigFile = ConfigFile.new()

	# config.set_value(SECTION, IS_FULLSCREEN_KEY, is_fullscreen)
	config.set_value(SECTION, RESOLUTION_KEY, resolution)

	config.save(path)


func set_window_mode(index: int) -> void:
	window_mode = window_modes[index]
	if window_mode == DisplayServer.WINDOW_MODE_WINDOWED:
		set_resolution(resolution)


func get_window_modes() -> Dictionary:
	return window_modes


func get_resolution() -> Vector2i:
	return resolution


func get_resolution_index() -> int:
	for i in resolutions.size():
		if resolution == resolutions[i]:
			return i
	return -1


func get_resolutions() -> Array[Vector2i]:
	return resolutions


func set_resolution(value: Vector2i) -> void:
	resolution = value
	get_window().size = value


func set_resolution_by_index(index: int) -> void:
	set_resolution(resolutions[index])
