extends Node2D

signal day_ended

export var time_limit : float
export(float, 0, 1) var pulsating_threshold : float

var curr_time := 0.0
var run := false

onready var clock_hand :=  $ClockHand
onready var animation := $Animation


func _ready():
	run = true


func _process(delta):
	if run:
		curr_time += delta
		clock_hand.rotation = 2 * PI * (curr_time / time_limit)
		if curr_time >= time_limit * pulsating_threshold:
			animation.play("pulsate")
		if curr_time >= time_limit:
			emit_signal("day_ended")
			run = false
			animation.stop()
			scale = Vector2.ONE
			print(scale)
