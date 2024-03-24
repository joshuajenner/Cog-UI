extends Control


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://examples/settings/settings.tscn")


func _on_quit_pressed():
	get_tree().quit()
