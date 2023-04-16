extends PanelContainer

@onready var label = %Label

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func show() -> void:
	visible = true


func set_text() -> void:
	label.text = "Esc to Cancel | Backspace to Unbind"
