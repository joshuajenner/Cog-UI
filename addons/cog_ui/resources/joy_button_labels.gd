class_name JoyButtonLabels
extends Resource


@export var NONE : String = ""
@export var LEFT : String = ""
@export var RIGHT : String = ""
@export var MIDDLE : String = ""
@export var WHEEL_UP : String = ""
@export var WHEEL_DOWN : String = ""
@export var WHEEL_LEFT : String = ""
@export var WHEEL_RIGHT : String = ""
@export var XBUTTON1 : String = ""
@export var XBUTTON2 : String = ""


func get_label(keycode: int) -> String:
	match (keycode):
		MOUSE_BUTTON_NONE:
			return NONE
		MOUSE_BUTTON_LEFT:
			return LEFT
		MOUSE_BUTTON_RIGHT:
			return RIGHT
		MOUSE_BUTTON_MIDDLE:
			return MIDDLE
		MOUSE_BUTTON_WHEEL_UP:
			return WHEEL_UP
		MOUSE_BUTTON_WHEEL_DOWN:
			return WHEEL_DOWN
		MOUSE_BUTTON_WHEEL_LEFT:
			return WHEEL_LEFT
		MOUSE_BUTTON_WHEEL_RIGHT:
			return WHEEL_RIGHT
		MOUSE_BUTTON_XBUTTON1:
			return XBUTTON1
		MOUSE_BUTTON_XBUTTON2:
			return XBUTTON2
		_:
			return ""
