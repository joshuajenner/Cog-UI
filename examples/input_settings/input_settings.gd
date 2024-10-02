extends MarginContainer


func _on_reset_pressed() -> void:
	InputSettings.load_defualt_settings()


func _on_save_pressed() -> void:
	InputSettings.save_user_settings()
