@tool
class_name Cog
extends EditorPlugin


# Edit the paths as needed
const VIDEO_SETTINGS_USER_PATH: String = "user://video_settings_user.cfg"
const VIDEO_SETTINGS_DEFAULT_PATH: String = "user://video_settings_default.cfg"


func _enter_tree():
	add_autoload_singleton("VideoSettings", "res://addons/cog/autoloads/video_settings.tscn")


func _exit_tree():
	remove_autoload_singleton("VideoSettings")
