@tool
extends EditorPlugin



enum {custom_name, parent_type, script_path, icon_path}
const number_slider : Array[String] = [
	"NumberSlider", 
	"BoxContainer", 
	"res://addons/cogui/nodes/number_slider.gd", 
	"res://addons/cogui/nodes/control.svg"
]



func _enter_tree():
	add_custom_type(number_slider[custom_name], number_slider[parent_type], preload(number_slider[script_path]), preload(number_slider[icon_path]))


func _exit_tree():
	remove_custom_type(number_slider[custom_name])
