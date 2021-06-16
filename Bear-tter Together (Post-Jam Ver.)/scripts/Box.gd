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
onready var top_sprite := $BoxSprites/Top
onready var bottom_sprite := $BoxSprites/Bottom

onready var poof_animation := $BoxSprites/PoofAnimation
onready var animation := $Animation

onready var emptying_label := $EmptyingLabel
onready var counter_label := $CounterLabel

onready var correct_audio_player := $CorrectAudio
onready var wrong_audio_player := $WrongAudio
onready var box_audio_container := $BoxAudio

onready var icon_pos := [$IconAPoint, $IconBPoint]

onready var player := $"../../Player"
onready var flying_money_container := $"../../FlyingMoneyContainer"
onready var money_dest := $"../../FlyingMoneyDestination"


func _ready():
	randomize()
	hide_correct_wrong()
	hide_labels()
	_hide_poof_animation()
	flying_money_scene = preload("res://scenes/FlyingMoney.tscn")
	connect("mouse_entered", self, "_on_Box_mouse_entered")
	connect("mouse_exited", self, "_on_Box_mouse_exited")
	player.connect("item_dropped", self, "_on_Box_item_dropped")
	poof_animation.connect("animation_finished", self, "_on_PoofAnimation_animation_finished")
	animation.connect("animation_finished", self, "_on_Animation_animation_finished")


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


func hide_labels() -> void:
	emptying_label.hide()
	counter_label.hide()


func _on_Box_item_dropped(item) -> void:
	if is_mouse_in and interactable:
		var size := items_inside.size()
		if size < 2:
			icon_pos[size].add_child(item_info.icons[item.type].instance())
			items_inside.append(item.type)
			animation.play("enlarge")
			player.drop()
			_play_box_sfx()
		if items_inside.size() == 2:
			_check_box()


func _check_box() -> void:
	var correct_match := true
	if item_info.can_join(items_inside):
		show_correct_msg()
		_instance_flying_money()
	else:
		show_wrong_msg()
		correct_match = false
	interactable = false
	var timer := get_tree().create_timer(TIME_TO_REMAIN_AFTER_FULL)
	timer.connect("timeout", self, "_destroy", [correct_match])


func _instance_flying_money() -> void:
	var instance := flying_money_scene.instance()
	instance.target = money_dest.position
	flying_money_container.add_child(instance)
	instance.global_position = global_position
	emit_signal("matched", instance)


func _destroy(correct_match: bool) -> void:
	for icon in icon_pos:
		if icon.get_children().size() > 0:
			icon.get_child(0).queue_free()
	hide_correct_wrong()
	items_inside.clear()
	if correct_match:
		_hide_box()
		poof_animation.play("poof")
	else:
		animation.play("emptying")


func _on_PoofAnimation_animation_finished() -> void:
	_hide_poof_animation()
	animation.play("appear")


func _on_Animation_animation_finished(anim_name: String) -> void:
	if anim_name == "appear" or anim_name == "emptying":
		interactable = true


func _on_Box_mouse_entered() -> void:
	is_mouse_in = true
	if player.has_item() and interactable:
		scale = Vector2(1.05, 1.05)


func _on_Box_mouse_exited() -> void:
	is_mouse_in = false
	scale = Vector2.ONE


func _hide_box() -> void:
	top_sprite.hide()
	bottom_sprite.hide()
	poof_animation.show()


func _hide_poof_animation() -> void:
	poof_animation.stop()
	poof_animation.hide()
	top_sprite.show()
	bottom_sprite.show()


func _play_box_sfx() -> void:
	var rand_index := randi() % box_audio_container.get_child_count()
	var audio : AudioStreamPlayer = box_audio_container.get_child(rand_index)
	audio.pitch_scale = rand_range(0.5, 4)
	audio.play()
