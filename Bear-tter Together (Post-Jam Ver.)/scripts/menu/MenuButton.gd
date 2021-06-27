extends Node

signal clicked

const HOVER_SIZE := Vector2(1.05, 1.05)

var is_mouse_in := false
var label_pos : Vector2

onready var sprite := $Sprite
onready var label := $Sprite/Label
onready var animation := $Animation


func _ready():
	label_pos = label.rect_position
	connect("mouse_entered", self, "_on_MenuButton_mouse_entered")
	connect("mouse_exited", self, "_on_MenuButton_mouse_exited")
	animation.connect("animation_finished", self, "_on_MenuButton_animation_finished")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and is_mouse_in:
			emit_signal("clicked")


func _on_MenuButton_animation_finished(anim_name: String) -> void:
	if anim_name == "enter":
		animation.play("hover")


func _on_MenuButton_mouse_entered() -> void:
	is_mouse_in = true
	animation.stop()
	sprite.scale = Vector2.ONE
	animation.play("enter")


func _on_MenuButton_mouse_exited() -> void:
	is_mouse_in = false
	animation.stop()
	sprite.scale = HOVER_SIZE
	label.rect_position = label_pos
	animation.play("exit")
