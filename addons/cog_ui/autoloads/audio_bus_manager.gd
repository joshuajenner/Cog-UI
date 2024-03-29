extends Node


signal bus_layout_changed
signal bus_layout_loaded
signal bus_layout_saved


func _ready():
	var file_exists: bool = ResourceLoader.exists(CogPaths.BUS_LAYOUT_USER_PATH)
	
	if file_exists:
		load_user_bus_layout()
	else:
		save_user_bus_layout()


func load_default_bus_layout() -> void:
	_load_bus_layout(CogPaths.BUS_LAYOUT_DEFAULT_PATH)


func load_user_bus_layout() -> void:
	_load_bus_layout(CogPaths.BUS_LAYOUT_USER_PATH)


func save_user_bus_layout() -> void:
	var bus_layout: AudioBusLayout = AudioServer.generate_bus_layout()
	ResourceSaver.save(bus_layout, CogPaths.BUS_LAYOUT_USER_PATH)
	bus_layout_saved.emit()


func _load_bus_layout(path: String) -> void:
	var file_layout: AudioBusLayout = ResourceLoader.load(path)
	AudioServer.set_bus_layout(file_layout)
	bus_layout_loaded.emit()
