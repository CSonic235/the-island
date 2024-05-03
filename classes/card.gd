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
var time:int

func _init(info:Dictionary):
	self.card_name = info.get("card_name")
	card_type = info.get("card_type")
	card_description = info.get("card_description")
	image_path = info.get("image_path")
	rarity = info.get("rarity")
	cost = info.get("cost")
	in_shop = info.get("in_shop")
	card_id = info.get("card_id")

func _to_string():
	return card_name