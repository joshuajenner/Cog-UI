class_name CogVideo
extends Node


@export var is_fullscreen: bool
@export var resolution: Vector2i
@export var resolutions: Array[Vector2i] = []


func init():
	var file_exists: bool = ResourceLoader.exists(CogPaths.USER_VIDEO_SETTINGS_PATH)
	
	if file_exists:
		load_settings()
	else:
		save_settings()


func get_resolution() -> Vector2i:
	return resolution

func get_resolution_index() -> int:
	for i in resolutions.size():
		if resolution == resolutions[i]:
			return i
	return -1

func get_resolutions() -> Array[Vector2i]:
	return resolutions


func load_settings():
	var vs: VideoSettings = ResourceLoader.load(CogPaths.USER_VIDEO_SETTINGS_PATH)
	# temp
	apply_is_fullscreen(is_fullscreen)
	apply_resolution(resolution)


func save_settings():
	var video_settings: VideoSettings = VideoSettings.new()
	ResourceSaver.save(video_settings, CogPaths.USER_VIDEO_SETTINGS_PATH)


func apply_is_fullscreen(value: bool) -> void:
	is_fullscreen = value
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func apply_resolution(value: Vector2i) -> void:
	resolution = value
	get_window().size = value

func apply_resolution_by_index(index: int) -> void:
	apply_resolution(resolutions[index])
