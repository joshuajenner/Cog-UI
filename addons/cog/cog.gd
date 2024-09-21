@tool
class_name Cog
extends EditorPlugin


# Edit the paths as needed
const BUS_LAYOUT_USER_PATH: String = "user://user_bus_layout.cfg"
const BUS_LAYOUT_DEFAULT_PATH: String = "res://default_bus_layout.tres"

const INPUT_MAP_USER_PATH: String = "user://user_input_map.cfg"

const VIDEO_SETTINGS_USER_PATH: String = "user://video_settings_user.cfg"
const VIDEO_SETTINGS_DEFAULT_PATH: String = "user://video_settings_default.cfg"


func _enter_tree():
	add_autoload_singleton("VideoSettings", "res://addons/cog/autoloads/video_settings.tscn")


func _exit_tree():
	remove_autoload_singleton("VideoSettings")
