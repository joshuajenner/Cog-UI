extends Node


var audio: CogAudio
var controls: CogControls
var video: CogVideo

var are_changes_pending: bool = false


func _ready():
	audio = $Audio
	controls = $Controls
	video = $Video
	# Using init instead of ready because the video settings resource tries to access
	# the Cog autoload before it has entered the scene, now we are doing it manually
	video.init()


func save_all():
	pass


