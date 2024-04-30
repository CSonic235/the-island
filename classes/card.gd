extends Node
class_name card
enum card_type {action_card,static_card,event_card}
var card_name:String
var card_description:String
enum rarity {common,uncommon,rare}
var cost:int
var card_id:int
var image_path:String


func __init(n:String):
	self.card_name = n

