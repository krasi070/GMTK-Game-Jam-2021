extends Node

const SIZE := 20
const COW := 0
const FARMER := 1
const NURSE := 2
const PATIENT := 3
const ZOO_KEEPER := 4
const NORMAL := 5
const KNIGHT := 6
const KING := 7
const COP := 8
const CRIMINAL := 9
const GROOM := 10
const BRIDE := 11
const KAREN := 12
const MANAGER := 13
const MAMA := 14
const BABIES := 15
const ANGEL := 16
const DEVIL := 17
const HONEY_POT := 18
const BOMB := 19

# Each bear has a specific bear type it is paired with except:
# Wife/Husband - You can pair a wife with a wife and a husband with a husband
# Honey Pot    - Can be paired up with any bear
# Bomb Bear    - Cannot be paired
const pairs := [
	[COW, FARMER],
	[NURSE, PATIENT],
	[ZOO_KEEPER, NORMAL],
	[KNIGHT, KING],
	[COP, CRIMINAL],
	[GROOM, GROOM],
	[GROOM, BRIDE],
	[BRIDE, BRIDE],
	[KAREN, MANAGER],
	[MAMA, BABIES],
	[ANGEL, DEVIL]
]

const name_arr := [
	"Cow Bear",
	"Farmer Bear",
	"Nurse Bear",
	"Patient Bear",
	"Zoo Keeper Bear",
	"Bear",
	"Knight Bear",
	"King Bear",
	"Cop Bear",
	"Criminal Bear",
	"Husband Bear",
	"Wife Bear",
	"Karen Bear",
	"Manager Bear",
	"Mama Bear",
	"Baby Bears",
	"Angel Bear",
	"Devil Bear",
	"Honey Pot",
	"Bomb Bear",
]

const COW_BEAR_SPRITE_SCENE := preload("res://scenes/bears/CowBearSprite.tscn")
const FARMER_BEAR_SPRITE_SCENE := preload("res://scenes/bears/FarmerBearSprite.tscn")
const NURSE_BEAR_SPRITE_SCENE := preload("res://scenes/bears/NurseBearSprite.tscn")
const PATIENT_BEAR_SPRITE_SCENE := preload("res://scenes/bears/PatientBearSprite.tscn")
const ZOO_KEEPER_BEAR_SPRITE_SCENE := preload("res://scenes/bears/ZooKeeperBearSprite.tscn")
const NORMAL_BEAR_SPRITE_SCENE := preload("res://scenes/bears/NormalBearSprite.tscn")
const KNIGHT_BEAR_SPRITE_SCENE := preload("res://scenes/bears/KnightBearSprite.tscn")
const KING_BEAR_SPRITE_SCENE := preload("res://scenes/bears/KingBearSprite.tscn")
const COP_BEAR_SPRITE_SCENE := preload("res://scenes/bears/CopBearSprite.tscn")
const CRIMINAL_BEAR_SPRITE_SCENE := preload("res://scenes/bears/CriminalBearSprite.tscn")
const GROOM_BEAR_SPRITE_SCENE := preload("res://scenes/bears/GroomBearSprite.tscn")
const BRIDE_BEAR_SPRITE_SCENE := preload("res://scenes/bears/BrideBearSprite.tscn")
const KAREN_BEAR_SPRITE_SCENE := preload("res://scenes/bears/KarenBearSprite.tscn")
const MANAGER_BEAR_SPRITE_SCENE := preload("res://scenes/bears/ManagerBearSprite.tscn")
const MAMA_BEAR_SPRITE_SCENE := preload("res://scenes/bears/MamaBearSprite.tscn")
const BABY_BEARS_SPRITE_SCENE := preload("res://scenes/bears/BabyBearsSprite.tscn")
const ANGEL_BEAR_SPRITE_SCENE := preload("res://scenes/bears/AngelBearSprite.tscn")
const DEVIL_BEAR_SPRITE_SCENE := preload("res://scenes/bears/DevilBearSprite.tscn")
const HONEY_POT_SPRITE_SCENE := preload("res://scenes/bears/HoneyPotSprite.tscn")
const BOMB_BEAR_SPRITE_SCENE := preload("res://scenes/bears/BombBearSprite.tscn")

const COW_BEAR_ICON_SCENE := preload("res://scenes/icons/CowBearIcon.tscn")
const FARMER_BEAR_ICON_SCENE := preload("res://scenes/icons/FarmerBearIcon.tscn")
const NURSE_BEAR_ICON_SCENE := preload("res://scenes/icons/NurseBearIcon.tscn")
const PATIENT_BEAR_ICON_SCENE := preload("res://scenes/icons/PatientBearIcon.tscn")
const ZOO_KEEPER_BEAR_ICON_SCENE := preload("res://scenes/icons/ZooKeeperBearIcon.tscn")
const NORMAL_BEAR_ICON_SCENE := preload("res://scenes/icons/NormalBearIcon.tscn")
const KNIGHT_BEAR_ICON_SCENE := preload("res://scenes/icons/KnightBearIcon.tscn")
const KING_BEAR_ICON_SCENE := preload("res://scenes/icons/KingBearIcon.tscn")
const COP_BEAR_ICON_SCENE := preload("res://scenes/icons/CopBearIcon.tscn")
const CRIMINAL_BEAR_ICON_SCENE := preload("res://scenes/icons/CriminalBearIcon.tscn")
const GROOM_BEAR_ICON_SCENE := preload("res://scenes/icons/GroomBearIcon.tscn")
const BRIDE_BEAR_ICON_SCENE := preload("res://scenes/icons/BrideBearIcon.tscn")
const KAREN_BEAR_ICON_SCENE := preload("res://scenes/icons/KarenBearIcon.tscn")
const MANAGER_BEAR_ICON_SCENE := preload("res://scenes/icons/ManagerBearIcon.tscn")
const MAMA_BEAR_ICON_SCENE := preload("res://scenes/icons/MamaBearIcon.tscn")
const BABY_BEARS_ICON_SCENE := preload("res://scenes/icons/BabyBearsIcon.tscn")
const ANGEL_BEAR_ICON_SCENE := preload("res://scenes/icons/AngelBearIcon.tscn")
const DEVIL_BEAR_ICON_SCENE := preload("res://scenes/icons/DevilBearIcon.tscn")
const HONEY_POT_ICON_SCENE := preload("res://scenes/icons/HoneyPotIcon.tscn")
const BOMB_BEAR_ICON_SCENE := preload("res://scenes/icons/BombBearIcon.tscn")

var sprites : Dictionary
var icons : Dictionary


func _ready():
	_set_bear_sprites()
	_set_bear_icons()


func can_join(items: Array) -> bool:
	for pair in pairs:
		if _are_pairs_equal(items, pair):
			return true
	return false


func _are_pairs_equal(pair_a: Array, pair_b: Array) -> bool:
	return (pair_a[0] == pair_b[0] and pair_a[1] == pair_b[1]) or \
			(pair_a[1] == pair_b[0] and pair_a[0] == pair_b[1]) or \
			(pair_a[0] == HONEY_POT or pair_a[1] == HONEY_POT)


func _set_bear_sprites() -> void:
	sprites[FARMER] = FARMER_BEAR_SPRITE_SCENE
	sprites[COW] = COW_BEAR_SPRITE_SCENE
	sprites[NURSE] = NURSE_BEAR_SPRITE_SCENE
	sprites[PATIENT] = PATIENT_BEAR_SPRITE_SCENE
	sprites[ZOO_KEEPER] = ZOO_KEEPER_BEAR_SPRITE_SCENE
	sprites[NORMAL] = NORMAL_BEAR_SPRITE_SCENE
	sprites[KNIGHT] = KNIGHT_BEAR_SPRITE_SCENE
	sprites[KING] = KING_BEAR_SPRITE_SCENE
	sprites[COP] = COP_BEAR_SPRITE_SCENE
	sprites[CRIMINAL] = CRIMINAL_BEAR_SPRITE_SCENE
	sprites[GROOM] = GROOM_BEAR_SPRITE_SCENE
	sprites[BRIDE] = BRIDE_BEAR_SPRITE_SCENE
	sprites[KAREN] = KAREN_BEAR_SPRITE_SCENE
	sprites[MANAGER] = MANAGER_BEAR_SPRITE_SCENE
	sprites[MAMA] = MAMA_BEAR_SPRITE_SCENE
	sprites[BABIES] = BABY_BEARS_SPRITE_SCENE
	sprites[ANGEL] = ANGEL_BEAR_SPRITE_SCENE
	sprites[DEVIL] = DEVIL_BEAR_SPRITE_SCENE
	sprites[HONEY_POT] = HONEY_POT_SPRITE_SCENE
	sprites[BOMB] = BOMB_BEAR_SPRITE_SCENE
	
	
func _set_bear_icons() -> void:
	icons[FARMER] = FARMER_BEAR_ICON_SCENE
	icons[COW] = COW_BEAR_ICON_SCENE
	icons[NURSE] = NURSE_BEAR_ICON_SCENE
	icons[PATIENT] = PATIENT_BEAR_ICON_SCENE
	icons[ZOO_KEEPER] = ZOO_KEEPER_BEAR_ICON_SCENE
	icons[NORMAL] = NORMAL_BEAR_ICON_SCENE
	icons[KNIGHT] = KNIGHT_BEAR_ICON_SCENE
	icons[KING] = KING_BEAR_ICON_SCENE
	icons[COP] = COP_BEAR_ICON_SCENE
	icons[CRIMINAL] = CRIMINAL_BEAR_ICON_SCENE
	icons[GROOM] = GROOM_BEAR_ICON_SCENE
	icons[BRIDE] = BRIDE_BEAR_ICON_SCENE
	icons[KAREN] = KAREN_BEAR_ICON_SCENE
	icons[MANAGER] = MANAGER_BEAR_ICON_SCENE
	icons[MAMA] = MAMA_BEAR_ICON_SCENE
	icons[BABIES] = BABY_BEARS_ICON_SCENE
	icons[ANGEL] = ANGEL_BEAR_ICON_SCENE
	icons[DEVIL] = DEVIL_BEAR_ICON_SCENE
	icons[HONEY_POT] = HONEY_POT_ICON_SCENE
	icons[BOMB] = BOMB_BEAR_ICON_SCENE


#func _create_texture(path: String) -> ImageTexture:
#	var image = Image.new()
#	var err = image.load(path)
#	if err != OK:
#		print("Path '%s' not found!" % path)
#	var texture = ImageTexture.new()
#	texture.create_from_image(image)
#	return texture
