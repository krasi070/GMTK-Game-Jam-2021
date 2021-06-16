extends Node

signal item_dropped

var item setget set_item

onready var hand_empty := $Empty
onready var hand_hold := $Hold


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_switch_to_empty_hand()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and has_item():
			emit_signal("item_dropped", item)


func _process(delta):
	hand_empty.position = get_viewport().get_mouse_position()
	hand_hold.position = get_viewport().get_mouse_position()


func drop() -> void:
	item.queue_free()
	item = null
	_switch_to_empty_hand()


func set_item(new_item):
	if !has_item():
		item = new_item
		item.get_parent().remove_child(item)
		add_child(item)
		_switch_to_hold_hand()


func has_item() -> bool:
	return item != null


func _switch_to_empty_hand() -> void:
	hand_empty.show()
	hand_hold.hide()


func _switch_to_hold_hand() -> void:
	hand_empty.hide()
	hand_hold.show()
