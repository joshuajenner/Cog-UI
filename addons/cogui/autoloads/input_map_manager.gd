extends Node

const INPUT_FILE_PATH : String = "user://user_input_map.tres"

var input_keys = {}


func _ready():
	load_user_input_map()
	print("Job's Done")


func load_user_input_map():
	var file_exists : bool = ResourceLoader.exists(INPUT_FILE_PATH)
	if file_exists:
		# load from file to input map
		pass
	else:
		pass


func create_user_input_map():
	var input_resource = InputMapResource.new()
	input_resource.init_input_map()
	ResourceSaver.save(input_resource, INPUT_FILE_PATH)






#func _ready():
#	save("[[\"yuh\"], [\"nuh\"]]")
#	read_file()
#
#
#func save(content):
#	var file = FileAccess.open("user://user_input_map.json", FileAccess.WRITE)
#	file.store_string(content)
#	file = null
#
#
#func read_file():
#	var file = FileAccess.open("user://user_input_map.json", FileAccess.READ)
#	var content = JSON.parse_string(file.get_as_text())
#	print("JSON: ", content) 
