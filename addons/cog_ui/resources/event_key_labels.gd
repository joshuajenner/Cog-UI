class_name EventKeyLabels
extends Resource


@export var _NONE : String = ""
@export var _SPECIAL : String = ""
@export var _ESCAPE  : String = ""
@export var _TAB : String = ""
@export var _BACKTAB : String = ""
@export var _BACKSPACE : String = ""
@export var _ENTER : String = ""
@export var _KP_ENTER : String = ""
@export var _INSERT : String = ""
@export var _DELETE : String = ""
@export var _PAUSE : String = ""
@export var _PRINT : String = ""
@export var _SYSREQ : String = ""
@export var _CLEAR : String = ""
@export var _HOME : String = ""
@export var _END : String = ""
@export var _LEFT : String = ""
@export var _UP : String = ""
@export var _RIGHT : String = ""
@export var _DOWN : String = ""
@export var _PAGEUP : String = ""
@export var _PAGEDOWN : String = ""
@export var _SHIFT : String = ""
@export var _CTRL : String = ""
@export var _META : String = ""
@export var _ALT : String = ""
@export var _CAPSLOCK : String = ""
@export var _NUMLOCK : String = ""
@export var _SCROLLLOCK : String = ""


func get_label(keycode: int):
	match (keycode):
		KEY_NONE:
			return KEY_NONE
		KEY_SPECIAL:
			return KEY_SPECIAL
		KEY_ESCAPE:
			return KEY_ESCAPE
		KEY_TAB:
			return KEY_TAB
		_:
			return ""
