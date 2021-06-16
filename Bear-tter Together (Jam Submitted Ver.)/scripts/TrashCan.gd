extends Area2D

export var limit := 5
export var progress_depletion_speed := 10

var is_mouse_in := false
var full := false
var items_inside : Array
var counter := 0

onready var label := $Label
onready var sprite_container := $SpriteContainer
onready var progress_bar := $TextureProgress
onready var animation := $Animation
onready var player := $"../Player"


func _ready():
	label.text = ""
	progress_bar.max_value = limit
	progress_bar.min_value = 0
	progress_bar.value = 0
	connect("mouse_entered", self, "_on_TrashCan_mouse_entered")
	connect("mouse_exited", self, "_on_TrashCan_mouse_exited")
	player.connect("item_dropped", self, "_on_TrashCan_item_dropped")


func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and \
			is_mouse_in and \
			full and \
			!player.has_item():
		if !animation.is_playing():
			animation.play("emptying", -1, 0.5)
		progress_bar.value -= delta * progress_depletion_speed
		counter = ceil(progress_bar.value)
		label.text = String(counter)
		if counter == 0:
			_stop_animation()
			full = false
	elif full:
		_stop_animation()
		progress_bar.value = limit
		counter = ceil(progress_bar.value)
		label.text = String(counter)


func _on_TrashCan_item_dropped(item) -> void:
	if is_mouse_in and counter < limit:
		counter += 1
		full = counter == limit
		progress_bar.value = counter
		label.text = String(counter)
		player.drop()
		animation.play("enlarge")


func _stop_animation():
	animation.stop()
	sprite_container.scale = Vector2.ONE


func _on_TrashCan_mouse_entered() -> void:
	is_mouse_in = true
	
	
func _on_TrashCan_mouse_exited() -> void:
	is_mouse_in = false
