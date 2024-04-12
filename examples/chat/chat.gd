extends MarginContainer


const CHAT_MESSAGE = preload("res://examples/chat/chat_message.tscn")

@onready var message_box = %MessageBox
@onready var chat_box = %ChatBox
@onready var scroll_box = %ScrollBox
@onready var message_panel = %MessagePanel

var max_scroll: float
var scroll_bar: ScrollBar

func _ready():
	scroll_box.custom_minimum_size = Vector2(0, 100)
	message_panel.self_modulate = Color(1,1,1,0.5)
	scroll_bar = scroll_box.get_v_scroll_bar()
	#scroll_bar.changed.connect(scroll_to_bottom)
	
	var msg = CHAT_MESSAGE.instantiate()
	msg.set_message(0, "Hello World!")
	message_box.add_child(msg)


func _on_line_edit_text_submitted(new_text):
	var msg = CHAT_MESSAGE.instantiate()
	msg.set_message(1, new_text)
	message_box.add_child(msg)
	chat_box.clear()
	var tween = get_tree().create_tween()
	tween.tween_property(scroll_box, "scroll_vertical", scroll_bar.max_value , 0.1)


func tween_chat(height: int, opacity: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(%ScrollBox, "custom_minimum_size", Vector2(0, height), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%MessagePanel, "self_modulate", Color(1,1,1,opacity), 0.2)
	tween.parallel().tween_property(scroll_box, "scroll_vertical", scroll_bar.max_value , 0.2)


func expand_chat() -> void:
	tween_chat(200, 1)

func minimize_chat() -> void:
	tween_chat(100, 0.5)


func scroll_to_bottom():
	if max_scroll != scroll_bar.max_value: 
		max_scroll = scroll_bar.max_value 
		scroll_box.scroll_vertical = max_scroll


func _on_chat_box_focus_entered():
	expand_chat()

func _on_chat_box_focus_exited():
	minimize_chat()
