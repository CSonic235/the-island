extends Control

@onready var display_text = $Panel/display
var dis_card = preload("res://scenes/DeckDisplay/dis_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var cards_data = create_possible_cards()
	for x in range(2):
		for n in range(3):
			var card_to_add:card = pick_a_card(cards_data)
			var card_instance = dis_card.instantiate()
			card_instance.update_card_info(card_to_add)
			card_instance.move_local_x(n*220) 
			card_instance.move_local_y(x*290+10) 
			self.add_child(card_instance)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(cards:play_cards):
	var discard_array = cards.discard_pile
	display_text.clear()
	for c in discard_array:
		display_text.add_text(str(c)+"\n")
	display_text.add_text(str(cards.cards_in_deck.size()))


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

func test(number_of_cards:int):
	var cards_data = create_possible_cards()
	var discard = []
	for x in range(number_of_cards):
		var card_to_add: card = pick_a_card(cards_data)
		discard.append(card_to_add)
	update(discard)

func pick_a_card(cards_data):
	var rng = RandomNumberGenerator.new()
	var index = rng.randi_range(0, cards_data.size() - 1)
	return cards_data[index]


func _on_button_pressed():
	hide()


func _on_show_discard_button_pressed():
	show()
