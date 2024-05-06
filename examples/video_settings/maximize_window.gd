extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	Cog.video.maximize_window()
