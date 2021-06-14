extends Node2D

signal added_money

export var target : Vector2
export var speed : float

var flying := false


func _ready():
	flying =  true


func _process(delta):
	if flying:
		print(position)
		position = position.move_toward(target, delta * speed)
	if position == target:
		queue_free()
		emit_signal("added_money")
