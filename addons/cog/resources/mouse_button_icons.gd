class_name MouseButtonIcons
extends Resource

@export var default : Texture2D
@export var NONE : Texture2D
@export var LEFT : Texture2D
@export var RIGHT : Texture2D
@export var MIDDLE : Texture2D
@export var WHEEL_UP : Texture2D
@export var WHEEL_DOWN : Texture2D
@export var WHEEL_LEFT : Texture2D
@export var WHEEL_RIGHT : Texture2D
@export var XBUTTON1 : Texture2D
@export var XBUTTON2 : Texture2D


func get_icon(keycode: int) -> Texture2D:
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
			return default
