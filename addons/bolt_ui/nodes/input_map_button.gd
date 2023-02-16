extends Button


@export var action : String
@export var index : int = 0

var key_label : String = ""


func _ready():
	# Get list of keys assigned to action
	# Get human readable key label, and set it as the display text
	var actions = InputMap.action_get_events(action)
	key_label = OS.get_keycode_string(actions[index].keycode)
	text = key_label
	
	print(InputMap.get_actions())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
