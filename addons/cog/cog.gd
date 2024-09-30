@tool
class_name Cog
extends EditorPlugin


# Edit the paths as needed
const VIDEO_SETTINGS_USER_PATH: String = "user://video_settings_user.cfg"
const VIDEO_SETTINGS_DEFAULT_PATH: String = "user://video_settings_default.cfg"

const AUDIO_SETTINGS_USER_PATH: String = "user://audio_settings_user.cfg"
const AUDIO_SETTINGS_DEFAULT_PATH: String = "res://default_bus_layout.tres"

const INPUT_SETTINGS_USER_PATH: String = "user://input_settings_user.cfg"
const INPUT_SETTINGS_DEFAULT_PATH: String = "user://input_settings_default.cfg"


func _enter_tree():
	add_autoload_singleton("VideoSettings", "res://addons/cog/autoloads/video_settings.tscn")
	add_autoload_singleton("AudioSettings", "res://addons/cog/autoloads/audio_settings.gd")
	add_autoload_singleton("InputSettings", "res://addons/cog/autoloads/input_settings.gd")


func _exit_tree():
	remove_autoload_singleton("VideoSettings")
	remove_autoload_singleton("AudioSettings")
	remove_autoload_singleton("InputSettings")
