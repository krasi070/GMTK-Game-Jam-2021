extends Area2D

const HOVER_ENLARGE_SIZE := Vector2(1.02, 1.02)

var is_mouse_in := false
var interactable := true setget set_interactable

onready var box_close_animation := $BoxCloseAnimation
onready var poof_animation := $PoofAnimation

onready var audio_player := $AudioStreamPlayer

onready var player := $"../Player"


func _ready():
	randomize()
	_hide_poof_animation()
	connect("mouse_entered", self, "_on_Box_mouse_entered")
	connect("mouse_exited", self, "_on_Box_mouse_exited")
	player.connect("item_dropped", self, "_on_Box_item_dropped")
	box_close_animation.connect("animation_finished", self, "_on_BoxCloseAnimation_animation_finished")
	poof_animation.connect("animation_finished", self, "_on_PoofAnimation_animation_finished")


func set_interactable(new_interactable: bool) -> void:
	interactable = new_interactable
	if interactable and is_mouse_in:
		scale = HOVER_ENLARGE_SIZE


func _on_Box_item_dropped(item) -> void:
	if is_mouse_in and interactable:
		player.drop()
		audio_player.play()
		box_close_animation.play("close")


func _on_BoxCloseAnimation_animation_finished() -> void:
	box_close_animation.hide()
	poof_animation.show()
	poof_animation.play("poof")


func _on_PoofAnimation_animation_finished() -> void:
	_hide_poof_animation()
	get_tree().change_scene("res://Main.tscn")


func _on_Box_mouse_entered() -> void:
	is_mouse_in = true
	if player.has_item() and interactable:
		scale = HOVER_ENLARGE_SIZE


func _on_Box_mouse_exited() -> void:
	is_mouse_in = false
	scale = Vector2.ONE


func _hide_poof_animation() -> void:
	poof_animation.stop()
	poof_animation.hide()
