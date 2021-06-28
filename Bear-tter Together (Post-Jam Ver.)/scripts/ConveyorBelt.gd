extends Node2D

enum Direction {LEFT = -1, RIGHT = 1}

const PART_ROTATION_MULTIPLIER := 1

export var speed : int
export var spawn_rate : float
export var direction := Direction.RIGHT

var item_info = ItemInfo
var bear_scene : PackedScene
var item_pool : Array

onready var spawner := $Spawner
onready var items := $Items
onready var item_timer := $ItemTimer
onready var bear_parts := [$BackBearPart, $FrontBearPart]
# Add BearParts to rotate them


func _ready():
	randomize()
	bear_scene = preload("res://scenes/Bear.tscn")
	item_timer.wait_time = spawn_rate
	item_timer.connect("timeout", self, "_on_ItemTimer_timeout")
	item_timer.start()


func _process(delta):
	var velocity = Vector2(direction * delta * speed, 0)
	_move_children(velocity)
	_rotate_parts(abs(velocity.x))


func spawn() -> void:
	var instance := bear_scene.instance()
	instance.position = spawner.position
	var rand_index : int = randi() % item_info.SIZE
	instance.type = rand_index
	items.add_child(instance)


func _on_ItemTimer_timeout() -> void:
	spawn()
	item_timer.wait_time = spawn_rate
	item_timer.stop()
	item_timer.start()


func _move_children(velocity: Vector2) -> void:
	for item in items.get_children():
		if !item.falling:
			item.position += velocity


func _rotate_parts(velocity: int) -> void:
	var to_add := velocity * PART_ROTATION_MULTIPLIER
	for part in bear_parts:
		part.rotate(deg2rad(to_add))
		print("%s: %f" % [part.name, part.rotation])
