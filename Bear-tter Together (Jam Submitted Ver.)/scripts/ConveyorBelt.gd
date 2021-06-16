extends Node2D

enum Direction {LEFT = -1, RIGHT = 1}

export var speed : int
export var spawn_rate : float
export var direction := Direction.RIGHT

var bear_type = BearType
var bear_scene : PackedScene
var item_pool : Array

onready var spawner := $Spawner
onready var items := $Items
onready var item_timer := $ItemTimer
# Add BearParts to rotate them


func _ready():
	randomize()
	bear_scene = preload("res://scenes/Bear.tscn")
	item_timer.wait_time = spawn_rate
	item_timer.connect("timeout", self, "_on_ItemTimer_timeout")
	item_timer.start()


func _process(delta):
	_move_children(delta)


func spawn() -> void:
	var instance := bear_scene.instance()
	instance.position = spawner.position
	var rand_index : int = randi() % item_pool.size()
	instance.type = item_pool[rand_index]
	items.add_child(instance)


func _on_ItemTimer_timeout() -> void:
	spawn()
	item_timer.wait_time = spawn_rate
	item_timer.stop()
	item_timer.start()


func _move_children(delta) -> void:
	var velocity = Vector2(direction * delta * speed, 0)
	for item in items.get_children():
		if !item.falling:
			item.position += velocity
