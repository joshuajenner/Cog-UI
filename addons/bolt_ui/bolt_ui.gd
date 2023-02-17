@tool
extends EditorPlugin



#enum {custom_name, parent_type, script_path, icon_path}
#const number_slider : Array[String] = [
#	"NumberSlider_N", 
#	"BoxContainer", 
#	"res://addons/bolt_ui/nodes/number_slider.gd", 
#	"res://addons/bolt_ui/nodes/control.svg"
#]
#const input_map_button : Array[String] = [
#	"InputMapButton_N", 
#	"Button", 
#	"res://addons/bolt_ui/nodes/input_map_button.gd", 
#	"res://addons/bolt_ui/nodes/control.svg"
#]



func _enter_tree():
#	add_custom_type(number_slider[custom_name], number_slider[parent_type], preload(number_slider[script_path]), preload(number_slider[icon_path]))
#	add_custom_type(input_map_button[custom_name], input_map_button[parent_type], preload(input_map_button[script_path]), preload(input_map_button[icon_path]))
	pass


func _exit_tree():
#	remove_custom_type(number_slider[custom_name])
#	remove_custom_type(input_map_button[custom_name])
	pass
