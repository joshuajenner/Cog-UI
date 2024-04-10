class_name CogAudio
extends Node


signal changed
signal loaded
signal saved


func _ready():
	var file_exists: bool = ResourceLoader.exists(CogPaths.BUS_LAYOUT_USER_PATH)
	
	if file_exists:
		load_user_bus_layout()
	else:
		save()


func load_default_bus_layout() -> void:
	_load(CogPaths.BUS_LAYOUT_DEFAULT_PATH)


func load_user_bus_layout() -> void:
	_load(CogPaths.BUS_LAYOUT_USER_PATH)


func save() -> void:
	var bus_layout: AudioBusLayout = AudioServer.generate_bus_layout()
	ResourceSaver.save(bus_layout, CogPaths.BUS_LAYOUT_USER_PATH)
	saved.emit()


func _load(path: String) -> void:
	var file_layout: AudioBusLayout = ResourceLoader.load(path)
	AudioServer.set_bus_layout(file_layout)
	loaded.emit()
