extends Control

var curr_level : int
var level_manager = LevelManager

onready var level_label := $LevelLabel

onready var empty_one_star := $EmptyStars/OneStar
onready var empty_two_stars := $EmptyStars/TwoStars
onready var empty_three_stars := $EmptyStars/ThreeStars

onready var filled_one_star := $FilledStars/OneStar
onready var filled_two_stars := $FilledStars/TwoStars
onready var filled_three_stars := $FilledStars/ThreeStars

onready var money_label := $MoneyLabel


func _ready():
	level_label.text = "Level %d" % level_manager.level
	money_label.text = "Money: %0.2f" % level_manager.money_got
	if level_manager.stars_got == 0:
		show_zero_stars()
	if level_manager.stars_got == 1:
		show_one_star()
	if level_manager.stars_got == 2:
		show_two_stars()
	if level_manager.stars_got == 3:
		show_three_stars()
	

func _input(event):
	if event.is_action_pressed("replay"):
		level_manager.replay_level()
	if event.is_action_pressed("next_level"):
		level_manager.next_level()
		

func show_zero_stars() -> void:
	empty_one_star.show()
	filled_one_star.hide()
	empty_two_stars.show()
	filled_two_stars.hide()
	empty_three_stars.show()
	filled_three_stars.hide()
		
		
func show_one_star() -> void:
	empty_one_star.hide()
	filled_one_star.show()
	empty_two_stars.show()
	filled_two_stars.hide()
	empty_three_stars.show()
	filled_three_stars.hide()


func show_two_stars() -> void:
	empty_one_star.hide()
	filled_one_star.show()
	empty_two_stars.hide()
	filled_two_stars.show()
	empty_three_stars.show()
	filled_three_stars.hide()
	
	
func show_three_stars() -> void:
	empty_one_star.hide()
	filled_one_star.show()
	empty_two_stars.hide()
	filled_two_stars.show()
	empty_three_stars.hide()
	filled_three_stars.show()
