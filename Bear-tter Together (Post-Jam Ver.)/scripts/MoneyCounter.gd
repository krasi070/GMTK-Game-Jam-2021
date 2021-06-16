extends Node2D

var money : float

onready var label := $Label
onready var box_area := $"../BoxArea"


func _ready():
	label.text = "%0.2f" % money
	for box in box_area.get_children():
		if box is Area2D:
			box.connect("matched", self, "_on_Box_matched")


func add_money(amount: float) -> void:
	money += amount
	label.text = "%0.2f" % money


func _on_Box_matched(flying_money) -> void:
	flying_money.connect("added_money", self, "_on_FlyingMoney_added_money")


func _on_FlyingMoney_added_money() -> void:
	add_money(2.5)
