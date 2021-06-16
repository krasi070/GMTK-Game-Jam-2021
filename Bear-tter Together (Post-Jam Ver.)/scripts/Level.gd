extends Node

const CLOCK_PULSATING_THRESHOLD := 0.75

export var level : int

export var time_limit : int
export var speed : int
export var spawn_rate : float

export var one_star_threshold : float
export var two_stars_threshold : float
export var three_stars_threshold : float

export var include_farmer_cow : bool
export var include_nurse_patient: bool
export var include_zoo_keeper_normal : bool
export var include_knight_king : bool
export var include_cop_criminial : bool
export var include_groom_bride : bool
export var include_karen_manager : bool
export var include_mama_babies : bool
export var include_angel_devil : bool
export var include_honey_pot : bool
export var include_bomb_bear : bool

var item_info = ItemInfo
var item_pool : Array
var level_manager = LevelManager

onready var back_conveyor_belt := $BackConveyorBelt
onready var middle_conveyor_belt := $MiddleConveyorBelt
onready var front_conveyor_belt := $FrontConveyorBelt
onready var clock := $Clock
onready var money_counter := $MoneyCounter


func _ready():
	_include_types()
	_set_conveyor_values()
	_set_clock_values()
	

func _set_conveyor_values() -> void:
	back_conveyor_belt.item_pool = item_pool
	back_conveyor_belt.spawn_rate = spawn_rate
	back_conveyor_belt.speed = speed
	
	middle_conveyor_belt.item_pool = item_pool
	middle_conveyor_belt.spawn_rate = spawn_rate
	middle_conveyor_belt.speed = speed
	
	front_conveyor_belt.item_pool = item_pool
	front_conveyor_belt.spawn_rate = spawn_rate
	front_conveyor_belt.speed = speed


func _set_clock_values() -> void:
	clock.time_limit = time_limit
	clock.pulsating_threshold = CLOCK_PULSATING_THRESHOLD
	clock.connect("day_ended", self, "_on_Clock_day_ended")


func _include_types() -> void:
	if include_farmer_cow:
		item_pool.append(item_info.FARMER)
		item_pool.append(item_info.COW)
	if include_nurse_patient:
		item_pool.append(item_info.NURSE)
		item_pool.append(item_info.PATIENT)
	if include_zoo_keeper_normal:
		item_pool.append(item_info.ZOO_KEEPER)
		item_pool.append(item_info.NORMAL)
	if include_knight_king:
		item_pool.append(item_info.KNIGHT)
		item_pool.append(item_info.KING)
	if include_cop_criminial:
		item_pool.append(item_info.COP)
		item_pool.append(item_info.CRIMINAL)
	if include_groom_bride:
		item_pool.append(item_info.GROOM)
		item_pool.append(item_info.BRIDE)
	if include_karen_manager:
		item_pool.append(item_info.KAREN)
		item_pool.append(item_info.MANAGER)
	if include_mama_babies:
		item_pool.append(item_info.MAMA)
		item_pool.append(item_info.BABIES)
	if include_angel_devil:
		item_pool.append(item_info.ANGEL)
		item_pool.append(item_info.DEVIL)
	if include_honey_pot:
		item_pool.append(item_info.HONEY_POT)
	if include_bomb_bear:
		item_pool.append(item_info.BOMB)


func _on_Clock_day_ended() -> void:
	var stars := _get_stars()
	level_manager.end_level(level, stars, money_counter.money)
	
	
func _get_stars() -> int:
	if money_counter.money < one_star_threshold:
		return 0
	if money_counter.money < two_stars_threshold:
		return 1
	if money_counter.money < three_stars_threshold:
		return 2
	return 3
