extends Area2D

const EMPTY_ME_TEXT := "Empty me!"
const EMPTYING_ANIM := "emptying"
const EMPTY_ME_ANIM := "empty_me"
const ENLARGE_ANIM := "enlarge"
const ENLARGE_ANIM_SPEED := 7.5
const FONT_SIZE := 28
const HOVER_ENLARGE_SIZE := Vector2(1.05, 1.05)

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
	label.hide()
	_set_progress_bar_init_values()
	connect("mouse_entered", self, "_on_TrashCan_mouse_entered")
	connect("mouse_exited", self, "_on_TrashCan_mouse_exited")
	player.connect("item_dropped", self, "_on_TrashCan_item_dropped")


func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and \
			is_mouse_in and \
			full and \
			!player.has_item():
		_empty_can(delta)
	elif full:
		_cancel_empty_can()


func _empty_can(delta) -> void:
	if !animation.is_playing() or animation.current_animation != EMPTYING_ANIM:
		_stop_animation()
		animation.play(EMPTYING_ANIM)
	progress_bar.value -= delta * progress_depletion_speed
	counter = ceil(progress_bar.value)
	if counter == 0:
		_stop_animation()
		full = false
		label.hide()


func _cancel_empty_can() -> void:
	if animation.current_animation != EMPTY_ME_ANIM:
		_stop_animation()
		label.text = EMPTY_ME_TEXT
		animation.play(EMPTY_ME_ANIM)
	progress_bar.value = limit
	counter = limit


func _set_progress_bar_init_values() -> void:
	progress_bar.max_value = limit
	progress_bar.min_value = 0
	progress_bar.value = 0


func _on_TrashCan_item_dropped(item) -> void:
	if is_mouse_in and counter < limit:
		counter += 1
		full = counter == limit
		progress_bar.value = counter
		player.drop()
		animation.play(ENLARGE_ANIM, -1, ENLARGE_ANIM_SPEED)
	if full:
		label.text = EMPTY_ME_TEXT
		label.show()


func _stop_animation():
	animation.stop()
	sprite_container.scale = Vector2.ONE
	label.get_font("font").size = FONT_SIZE
	label.align = Label.ALIGN_LEFT


func _on_TrashCan_mouse_entered() -> void:
	is_mouse_in = true
	if player.has_item():
		sprite_container.scale = HOVER_ENLARGE_SIZE
	
	
func _on_TrashCan_mouse_exited() -> void:
	is_mouse_in = false
	sprite_container.scale = Vector2.ONE
