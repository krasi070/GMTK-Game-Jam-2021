extends Node

const paths := [
	"res://scenes/levels/InBetweenLevelMenu.tscn",
	"res://scenes/levels/LevelOne.tscn",
	"res://scenes/levels/LevelTwo.tscn",
	"res://scenes/levels/LevelThree.tscn",
	"res://scenes/levels/LevelFour.tscn",
	"res://scenes/levels/LevelFive.tscn",
]

var level : int
var stars_got : int
var money_got : float


func end_level(ended_level: int, stars: int, money: float) -> void:
	level = ended_level
	stars_got = stars
	money_got = money
	get_tree().change_scene(paths[0])

	
func replay_level() -> void:
	get_tree().change_scene(paths[level])


func next_level() -> void:
	var next = level + 1
	if next > 5:
		get_tree().change_scene("res://scenes/levels/EndScreen.tscn")
	get_tree().change_scene(paths[next])
