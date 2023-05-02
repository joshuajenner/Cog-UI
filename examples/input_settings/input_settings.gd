extends Control


@onready var unbind = %Unbind
@onready var cancel_bind = %CancelBind


# Called when the node enters the scene tree for the first time.
func _ready():
	InputMapManager.edit_completed.connect(_on_edit_completed)
	InputMapManager.edit_requested.connect(_on_edit_requested)
	InputMapManager.edit_canceled.connect(_on_edit_completed)
	_show_instructions(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_edit_requested():
	_show_instructions(true)


func _on_edit_completed(_action):
	_show_instructions(false)


func _show_instructions(shown: bool) -> void:
	unbind.visible = shown
	cancel_bind.visible = shown
