class_name ActionIcon
extends Node


@export var action: String = ""


func _ready():
	Cog.controls.edit_completed.connect(_update_action)
	_update_action(action)


func _update_action(updated_action: String) -> void:
	if updated_action == action:
		update_display(Cog.controls.get_event_icon(action, 0))


func update_display(new_display: Texture2D) -> void:
	pass
