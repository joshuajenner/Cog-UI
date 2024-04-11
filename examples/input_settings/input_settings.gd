extends MarginContainer


func _ready():
	Cog.controls.edit_completed.connect(_on_edit_completed)
	Cog.controls.edit_requested.connect(_on_edit_requested)
	Cog.controls.edit_canceled.connect(_on_edit_completed)


func _on_edit_requested():
	pass


func _on_edit_completed(_action):
	pass


func _on_save_pressed():
	Cog.controls.save_user_input_map()


func _on_reset_pressed():
	Cog.controls.load_user_input_map()
