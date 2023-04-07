class_name SystemClock
extends Label


func _physics_process(_delta) -> void:
	var time_dict : Dictionary = Time.get_time_dict_from_system()
	var display : String = ("%02d" % time_dict.hour) + ":" + ("%02d" % time_dict.minute)
	
	text = display
