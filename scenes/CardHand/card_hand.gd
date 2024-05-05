extends Control

var card_scene = preload("res://scenes/CardHand/card.tscn")
@onready var cards_container = $MarginContainer/CardContainer
@onready var margin_container = $MarginContainer
func _ready():
	update_hand([])
''' 	var cards_data = create_possible_cards()
	var cards_in_hand = cards_container.get_children()
	print(cards_in_hand)
	for c in cards_in_hand:
		print(c)
		var card_to_add: card = pick_a_card(cards_data) 
		c.update_card_info(card_to_add) '''
''' 			margin_container.add_child(card_instance)
			card_position.x += 100 
			self.add_child(card_instance) '''


func pick_a_card(cards_data):
	var rng = RandomNumberGenerator.new()
	var index = rng.randi_range(0, cards_data.size() - 1)
	return cards_data[index]

func create_possible_cards():
	var file = "res://data/cards.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)

	var possible_cards = []
	for c in json_as_dict:
		if c.in_shop:
			var rarity = c.rarity
			var card_to_add = card.new(c)
			for i in 4 - rarity:
				possible_cards.append(card_to_add)

	return possible_cards

func update_hand(hand:Array):
	var cards_in_hand = cards_container.get_children()
	for x in range(cards_in_hand.size()):
		if x <  hand.size():
			var card_to_be_displayed = hand[x]
			cards_in_hand[x].update_card_info(card_to_be_displayed)
			cards_in_hand[x].show()
		else:
			cards_in_hand[x].hide()

func test_hand(number_of_cards:int):
	var cards_data = create_possible_cards()
	var hand_array = []
	for x in range(number_of_cards):
		var card_to_add: card = pick_a_card(cards_data)
		hand_array.append(card_to_add)
	update_hand(hand_array)
		



