@icon("res://addons/bolt_ui/classes/control.svg")
class_name AudioSlider
extends HSlider

@export var audio_bus : String
@export var label : Control

var bus_index : int


# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index(audio_bus)




func _on_drag_ended(value_changed):
	pass # Replace with function body.


func _on_value_changed(value):
	pass # Replace with function body.
