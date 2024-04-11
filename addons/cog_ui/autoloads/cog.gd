extends Node


var audio: CogAudio
var controls: CogControls

var are_changes_pending: bool = false


func _ready():
	audio = $Audio
	controls = $Controls


func save_all():
	pass


