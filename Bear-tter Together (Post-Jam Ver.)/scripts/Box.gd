extends Area2D

signal matched

const TIME_TO_REMAIN_AFTER_FULL = 1

var is_mouse_in := false
var interactable := true
var items_inside : Array
var item_info = ItemInfo
var flying_money_scene : PackedScene

onready var correct_sprite := $Correct
onready var wrong_sprite := $Wrong
onready var animation := $Animation
onready var correct_audio_player := $CorrectAudio
onready var wrong_audio_player := $WrongAudio
onready var icon_pos := [$IconAPoint, $IconBPoint]
onready var player := $"../../Player"
onready var flying_money_container := $"../../FlyingMoneyContainer"
onready var money_dest := $"../../FlyingMoneyDestination"


func _ready():
	hide_correct_wrong()
	flying_money_scene = preload("res://scenes/FlyingMoney.tscn")
	connect("mouse_entered", self, "_on_Box_mouse_entered")
	connect("mouse_exited", self, "_on_Box_mouse_exited")
	player.connect("item_dropped", self, "_on_Box_item_dropped")


func hide_correct_wrong() -> void:
	correct_sprite.hide()
	wrong_sprite.hide()


func show_correct_msg() -> void:
	correct_sprite.show()
	wrong_sprite.hide()
	correct_audio_player.play()


func show_wrong_msg() -> void:
	correct_sprite.hide()
	wrong_sprite.show()
	wrong_audio_player.play()


func _on_Box_item_dropped(item) -> void:
	if is_mouse_in and interactable:
		var size := items_inside.size()
		if size < 2:
			icon_pos[size].add_child(item_info.icons[item.type].instance())
			items_inside.append(item.type)
			animation.play("enlarge")
			player.drop()
		if items_inside.size() == 2:
			_check_box()


func _check_box() -> void:
	if item_info.can_join(items_inside):
		show_correct_msg()
		_instance_flying_money()
	else:
		show_wrong_msg()
	interactable = false
	var timer := get_tree().create_timer(TIME_TO_REMAIN_AFTER_FULL)
	timer.connect("timeout", self, "_destroy")


func _instance_flying_money() -> void:
	var instance := flying_money_scene.instance()
	instance.target = money_dest.position
	flying_money_container.add_child(instance)
	instance.global_position = global_position
	emit_signal("matched", instance)


func _destroy() -> void:
	# Play animation here
	for icon in icon_pos:
		if icon.get_children().size() > 0:
			icon.get_child(0).queue_free()
	hide_correct_wrong()
	items_inside.clear()
	interactable = true


func _on_Box_mouse_entered() -> void:
	is_mouse_in = true
	
	
func _on_Box_mouse_exited() -> void:
	is_mouse_in = false
