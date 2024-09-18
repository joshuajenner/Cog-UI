class_name VideoSettings
extends Resource


@export var is_fullscreen: bool
@export var resolution: Vector2i


func _init():
	is_fullscreen = Cog.video.is_fullscreen
	resolution = Cog.video.resolution
