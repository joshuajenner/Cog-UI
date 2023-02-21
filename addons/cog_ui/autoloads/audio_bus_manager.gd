extends Node

const AUDIO_FILE_PATH : String = "user://user_audio_settings.tres"


func _ready():
	var file_exists = ResourceLoader.exists(AUDIO_FILE_PATH)
	
	if file_exists:
		load_file_to_bus_layout()
	else:
		save_bus_layout_to_file()


func load_file_to_bus_layout():
	var file_layout = ResourceLoader.load(AUDIO_FILE_PATH)
	AudioServer.set_bus_layout(file_layout)


func save_bus_layout_to_file():
	var bus_layout = AudioServer.generate_bus_layout()
	ResourceSaver.save(bus_layout, AUDIO_FILE_PATH)
