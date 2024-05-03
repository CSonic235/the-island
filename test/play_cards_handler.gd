extends Node2D
@onready var cards_possible = create_possible_cards()
@onready var play_area :play_cards= play_cards.new([]) 

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp_deck = []
	for x in range(10):
		temp_deck.append(pick_a_card())
	play_area
	print(play_area.cards_in_deck)


func create_possible_cards():
	var file = "res://data/cards.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)

	var possible_cards:Array = []
	for c in json_as_dict:
		if c.in_shop:
			var rarity:int = c.rarity
			var card_to_add:card = card.new(c)
			for i in 4-rarity:
				possible_cards.append(card_to_add)
	return 	possible_cards

func pick_a_card():
	var rng = RandomNumberGenerator.new()
	var index =rng.randi_range(0, cards_possible.size()-1)
	print(cards_possible[index].get_class)
	return cards_possible[index]

func display_cards_in_deck():
	print(play_area.cards_in_deck)