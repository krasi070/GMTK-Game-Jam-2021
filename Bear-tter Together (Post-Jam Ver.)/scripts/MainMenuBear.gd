extends Area2D

var picked_up := false
var is_mouse_in := false
var bear_textures : Dictionary

onready var player := $"../Player"


func _ready():
	connect("mouse_entered", self, "_on_Bear_mouse_entered")
	connect("mouse_exited", self, "_on_Bear_mouse_exited")


func _process(delta):
	if picked_up:
		position = get_viewport().get_mouse_position()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_mouse_in and !player.has_item():
				grabbed()


func grabbed() -> void:
	# Set item and player values
	picked_up = true
	player.item = self
	# Change sprite drawing order
	var sprite := _get_sprite()
	sprite.offset = Vector2.ZERO


func _on_Bear_mouse_entered() -> void:
	is_mouse_in = true


func _on_Bear_mouse_exited() -> void:
	is_mouse_in = false


func _get_sprite() -> Sprite:
	for child in get_children():
		if child is Sprite:
			return child
	return null
