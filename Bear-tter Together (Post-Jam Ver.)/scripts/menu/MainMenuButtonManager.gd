extends Node

onready var endless_button := $EndlessButton
onready var levels_button := $LevelsButton
onready var quit_button := $QuitButton


func _ready():
	endless_button.connect("clicked", self, "_on_EndlessButton_clicked")
	levels_button.connect("clicked", self, "_on_LevelsButton_clicked")
	quit_button.connect("clicked", self, "_on_QuitButton_clicked")


func _on_EndlessButton_clicked() -> void:
	# TODO: Change to actual endless level scene later
	get_tree().change_scene("res://Main.tscn")


func _on_LevelsButton_clicked() -> void:
	# TODO: Change to actual level select scene later
	get_tree().change_scene("res://Main.tscn")


func _on_QuitButton_clicked() -> void:
	get_tree().quit()
