extends Control


func _ready():
	InputMapManager.edit_completed.connect(_on_edit_completed)
	InputMapManager.edit_requested.connect(_on_edit_requested)
	InputMapManager.edit_canceled.connect(_on_edit_completed)


func _on_edit_requested():
	pass


func _on_edit_completed(_action):
	pass


func _on_save_pressed():
	InputMapManager.save_user_input_map()


func _on_reset_pressed():
	InputMapManager.load_user_input_map()
