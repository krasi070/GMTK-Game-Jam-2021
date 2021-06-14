extends Area2D

var destroyed_items_count := 0

onready var fire := $Fire
onready var conveyor_item_container := $"../Items"

func _ready():
	hide_fire()
	connect("area_entered", self, "_on_EndHole_area_entered")
	fire.connect("animation_finished", self, "_on_Fire_animation_finished")


func hide_fire() -> void:
	fire.hide()


func _on_EndHole_area_entered(area: Area2D) -> void:
	if "picked_up" in area and !area.picked_up and area.get_parent() == conveyor_item_container:
		area.queue_free()
		destroyed_items_count += 1
		fire.show()
		fire.play("burn")
		#var timer := get_tree().create_timer(0.3)
		#timer.connect("timeout", self, "hide_fire")


func _on_Fire_animation_finished() -> void:
	fire.stop()
	fire.hide()
