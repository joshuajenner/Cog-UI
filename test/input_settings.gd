extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_save_button_down():
	InputMapManager.save_settings_to_resource()


func _on_cancel_button_down():
	get_tree().quit()
