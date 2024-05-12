extends Node
class_name card
enum CardType {action_card,static_card,event_card}
enum Rarity {common,uncommon,rare,mythic}
var card_type:CardType
var card_name:String
var card_description:String
var rarity:Rarity
var cost:int
var card_id:int
var image_path:String
var in_shop:bool
var times:int
var action_attributes: Dictionary
var static_attributes: Dictionary

var hot_count=0
var cold_count=0
var windy_count=0
var humid_count=0
var dry_count=0
var wet_count=0
var fish_count=0
var fertile_soil_count=0
var infertile_soil_count=0

func _init(info:Dictionary):
	self.card_name = info.get("card_name")
	card_type = info.get("card_type")
	card_description = info.get("card_description")
	image_path = info.get("image_path")
	rarity = info.get("rarity")
	cost = info.get("cost")
	in_shop = info.get("in_shop")
	card_id = info.get("card_id")
	if card_type == 0:
		action_attributes = info.get("action_attributes")

func _to_string():
	return card_name
