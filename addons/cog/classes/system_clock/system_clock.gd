class_name SystemClock
extends Label

## Attach to a Label to automatically display the system time.

enum FORMAT {
	_24_Hour, ## Eg. 13:00
	_12_Hour ## Eg. 01:00 PM
}

## Select which format to display the time in.
@export var format: FORMAT


func _physics_process(_delta) -> void:
	var time_dict: Dictionary = Time.get_time_dict_from_system()
	text = _display_string(time_dict)


func _display_string(time_dict: Dictionary) -> String:
	if format == FORMAT._24_Hour:
		return ("%02d" % time_dict.hour) + ":" + ("%02d" % time_dict.minute)
	else:
		var suffix: String = " PM" if time_dict.hour >= 12 else " AM"
		var hour: int = 12 if (time_dict.hour % 12) == 0 else (time_dict.hour % 12)
		return ("%02d" % hour) + ":" + ("%02d" % time_dict.minute) + suffix
