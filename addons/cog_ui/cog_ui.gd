@tool
extends EditorPlugin

enum {
	auto_name,
	path
}

const input_map_manager : Array[String] = ["InputMapManager", "res://addons/cog_ui/autoloads/input_map_manager.gd"]
const audio_bus_manager : Array[String] = ["AudioBusManager", "res://addons/cog_ui/autoloads/audio_bus_manager.gd"]

func _enter_tree():
	add_autoload_singleton(input_map_manager[auto_name], input_map_manager[path])
	add_autoload_singleton(audio_bus_manager[auto_name], audio_bus_manager[path])


func _exit_tree():
	remove_autoload_singleton(input_map_manager[auto_name])
	remove_autoload_singleton(audio_bus_manager[auto_name])
