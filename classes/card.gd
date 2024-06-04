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
var in_starter:bool
var times:int
var action_attributes: Dictionary
var static_attributes: Dictionary

func _init(info:Dictionary):
	self.card_name = info.get("card_name")
	card_type = info.get("card_type")
	card_description = info.get("card_description")
	image_path = info.get("image_path")
	rarity = info.get("rarity")
	cost = info.get("cost")
	in_shop = info.get("in_shop")
	in_starter = info.get("in_starter")
	card_id = info.get("card_id")
	
	match card_type:
		CardType.action_card:
			action_attributes = info.get("action_attributes")
		CardType.static_card:
			static_attributes = info.get("static_attributes")
		CardType.event_card:
			action_attributes = info.get("action_attributes")
			pass
		
	'''if card_type == 0:
		action_attributes = info.get("action_attributes")
	if card_type == 1:
		static_attributes = info.get("static_attributes")'''
		
func _to_string():
	return card_name
