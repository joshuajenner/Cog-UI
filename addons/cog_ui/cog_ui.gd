@tool
extends EditorPlugin

enum {
	auto_name,
	path
}

const audio_bus_manager : Array[String] = ["AudioBusManager", "res://addons/cog_ui/autoloads/audio_bus_manager.gd"]

func _enter_tree():
	add_autoload_singleton(audio_bus_manager[auto_name], audio_bus_manager[path])


func _exit_tree():
	remove_autoload_singleton(audio_bus_manager[auto_name])
