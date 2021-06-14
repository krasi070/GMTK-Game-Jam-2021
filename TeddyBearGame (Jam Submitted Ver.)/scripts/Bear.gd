extends Area2D

export var fall_speed := 200

var picked_up := false
var falling := false
var is_mouse_in := false
var bear_type = BearType
var type : int setget set_type
var bear_textures : Dictionary

onready var animation := $Animation
onready var player := $"../../../Player"
onready var end_area := $"../../EndArea"


func _ready():
	connect("mouse_entered", self, "_on_Bear_mouse_entered")
	connect("mouse_exited", self, "_on_Bear_mouse_exited")
	end_area.connect("area_entered", self, "_on_EndArea_area_entered")
	add_child(bear_type.sprites[type].instance())


func _process(delta):
	if picked_up:
		position = get_viewport().get_mouse_position()
	if falling:
		var velocity = delta * fall_speed
		position += Vector2(0, velocity)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_mouse_in and !player.has_item():
				grabbed()


func set_type(new_type: int) -> void:
	type = new_type


func grabbed() -> void:
	animation.stop()
	rotation = 0
	falling = false
	picked_up = true
	player.item = self
	var sprite := _get_sprite()
	sprite.offset = Vector2.ZERO


func _on_Bear_mouse_entered() -> void:
	is_mouse_in = true


func _on_Bear_mouse_exited() -> void:
	is_mouse_in = false


func _on_EndArea_area_entered(area: Area2D) -> void:
	if self == area and !picked_up:
		var direction = end_area.get_parent().direction
		# Direction.RIGHT is equal to 1 while Direction.LEFT is -1
		if direction == 1:
			animation.play("fall", -1, 3)
		else:
			animation.play("fall_left", -1, 3)
		falling = true


func _get_sprite() -> Sprite:
	for child in get_children():
		if child is Sprite:
			return child
	return null
