extends Node2D
@onready var cards_possible = create_possible_cards()
@onready var play_area :play_cards
signal card_effect(attribute:Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("card_player").affects_deck.connect(_on_affects_deck)
	get_node("card_player").affects_world.connect(_on_affects_world)
	var temp_deck = []
	for x in range(10):
		temp_deck.append(pick_a_card())
	play_area = play_cards.new(temp_deck) 
	'''play_area.draw()
	print("drew 3 cards hand is", str(play_area.hand))
	play_card(0)
	print("played card 0, hand is ",play_area.hand,"discard is",play_area.discard_pile)
 
	just a bunch of functcalled methods to test that the code is working
	print(play_area.cards_in_deck)
	play_area.draw()
	play_area.draw()
	play_area.draw()
	print("drew 3 cards hand is", str(play_area.hand))
	play_area.play_card(0)
	print("played card 0, hand is ",play_area.hand,"discard is",play_area.discard_pile)
	night_actions()
	print("reset deck, deck is,", str(play_area.cards_in_deck))
	play_area.shuffle()
	print("shuffled deck, deck is,", str(play_area.cards_in_deck))
	play_area.shuffle()
	print("shuffled deck, deck is,", str(play_area.cards_in_deck))  '''

func _on_affects_deck(d:Dictionary):
	for x in d:
		if x =="draw_cards":
			var cards_drawn:int = d.get(x)
			draw_cards(cards_drawn)
			print("drew cards, hand is",play_area.hand)
		elif x =="discard_cards":
			play_area.discard(d.get(x))
			print("discard cards, hand is",play_area.hand)
		elif x ==  "remove":
			play_area.remove(0)
			print("discard cards, hand is",play_area.hand)
	print("signal recieved",d)


func _on_affects_world(d:Dictionary):
	print("signal recieved",d)
	card_effect.emit(d)
	print("signal sent")
func create_possible_cards():
	var file = "res://data/cards.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)

	var possible_cards:Array = []
	for c in json_as_dict:
		if c.in_shop==true:
			var rarity:int = c.rarity
			var card_to_add:card = card.new(c)
			for i in 4-rarity:
				possible_cards.append(card_to_add)
	return 	possible_cards

func pick_a_card():
	var rng = RandomNumberGenerator.new()
	var index =rng.randi_range(0, cards_possible.size()-1)
	return cards_possible[index]

func display_cards_in_deck():
	print(play_area.cards_in_deck)

func night_actions():
	play_area.reset_deck()
func draw_cards(x:int):
	for times_repeated in range(x):
		play_area.draw()

func play_card(i:int):
	var card_played:card = play_area.play_card(i)
	$card_player.play_card(card_played)
	return card_played

func get_card_in_hand(index:int):
	if index <play_area.hand.size():
		return play_area.hand[index]

func get_hand():
	return play_area.hand