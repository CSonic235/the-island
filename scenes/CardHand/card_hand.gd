extends Control

var card_scene = preload("res://scenes/CardHand/card.tscn")

func _ready():
	var cards_data = create_possible_cards()
	var margin_container = $MarginContainer
	
	var initial_position = margin_container.global_position
	var card_position = initial_position + Vector2(150, 16)

	for card_index in range(1, 7):
			var card_to_add: card = pick_a_card(cards_data) 
			var card_instance = card_scene.instantiate()
			card_instance.update_card_info(card_to_add)
			card_instance.set_position(card_position)
			margin_container.add_child(card_instance)
			card_position.x += 100 
			self.add_child(card_instance)


func pick_a_card(cards_data):
	var rng = RandomNumberGenerator.new()
	var index = rng.randi_range(0, cards_data.size() - 1)
	print(cards_data[index].get_class())
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



