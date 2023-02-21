@tool
extends EditorPlugin

enum {
	auto_name,
	path
}

const input_map : Array[String] = ["InputMapManager", "res://addons/cog_ui/autoloads/input_map_manager.gd"]


func _enter_tree():
	add_autoload_singleton(input_map[auto_name], input_map[path])


func _exit_tree():
	remove_autoload_singleton(input_map[auto_name])
