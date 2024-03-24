class_name SystemClock
extends Label


enum FORMAT {
	_24_Hour,
	_12_Hour
}

@export var format: FORMAT


func _physics_process(_delta) -> void:
	var time_dict: Dictionary = Time.get_time_dict_from_system()
	text = _display_string(time_dict)


func _display_string(time_dict: Dictionary) -> String:
	if format == FORMAT._24_Hour:
		return ("%02d" % time_dict.hour) + ":" + ("%02d" % time_dict.minute)
	else:
		var suffix: String = " PM" if time_dict.hour >= 12 else " AM"
		return ("%02d" % (time_dict.hour - 12)) + ":" + ("%02d" % time_dict.minute) + suffix
