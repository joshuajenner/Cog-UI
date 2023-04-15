class_name JoyButtonLabels
extends Resource


@export var INVALID : String = ""
@export var A : String = ""
@export var B : String = ""
@export var X : String = ""
@export var Y : String = ""
@export var BACK : String = ""
@export var GUIDE : String = ""
@export var START : String = ""
@export var LEFT_STICK : String = ""
@export var RIGHT_STICK : String = ""
@export var LEFT_SHOULDER : String = ""
@export var RIGHT_SHOULDER : String = ""
@export var DPAD_UP : String = ""
@export var DPAD_DOWN : String = ""
@export var DPAD_LEFT : String = ""
@export var DPAD_RIGHT : String = ""
@export var MISC1 : String = ""
@export var PADDLE1 : String = ""
@export var PADDLE2 : String = ""
@export var PADDLE3 : String = ""
@export var PADDLE4 : String = ""
@export var TOUCHPAD : String = ""


func get_label(keycode: int) -> String:
	match (keycode):
		JOY_BUTTON_INVALID:
			return INVALID
		JOY_BUTTON_A:
			return A
		JOY_BUTTON_B:
			return B
		JOY_BUTTON_X :
			return X
		JOY_BUTTON_Y:
			return Y
		JOY_BUTTON_BACK:
			return BACK
		JOY_BUTTON_GUIDE:
			return GUIDE
		JOY_BUTTON_START:
			return START
		JOY_BUTTON_LEFT_STICK:
			return LEFT_STICK
		JOY_BUTTON_RIGHT_STICK:
			return RIGHT_STICK
		JOY_BUTTON_LEFT_SHOULDER:
			return LEFT_SHOULDER
		JOY_BUTTON_RIGHT_SHOULDER:
			return RIGHT_SHOULDER
		JOY_BUTTON_DPAD_UP:
			return DPAD_UP
		JOY_BUTTON_DPAD_DOWN:
			return DPAD_DOWN
		JOY_BUTTON_DPAD_LEFT:
			return DPAD_LEFT
		JOY_BUTTON_DPAD_RIGHT:
			return DPAD_RIGHT
		JOY_BUTTON_MISC1:
			return MISC1
		JOY_BUTTON_PADDLE1:
			return PADDLE1
		JOY_BUTTON_PADDLE2:
			return PADDLE2
		JOY_BUTTON_PADDLE3:
			return PADDLE3
		JOY_BUTTON_PADDLE4:
			return PADDLE4
		JOY_BUTTON_TOUCHPAD:
			return TOUCHPAD
		_:
			return ""
