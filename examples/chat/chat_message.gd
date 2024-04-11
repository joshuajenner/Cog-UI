extends MarginContainer


@onready var name_label = $HBox/Name
@onready var message_label = $HBox/Message

enum Sender {SYSTEM, USER}

var sender: Sender
var message: String


func _ready() -> void:
	display_message()


func set_message(from: Sender, msg: String) -> void:
	sender = from
	message = msg


func display_message() -> void:
	if sender == Sender.SYSTEM:
		name_label.text = "[System]:"
		name_label.add_theme_color_override("font_color", Color.HOT_PINK)
	else:
		name_label.text = "User:"
		name_label.add_theme_color_override("font_color", Color.DODGER_BLUE)
	
	message_label.text = message
