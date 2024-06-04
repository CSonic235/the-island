extends Node
class_name play_cards

var cards_in_deck:Array[card] =[]
var discard_pile:Array[card] =[]
var hand:Array[card] =[]

func _init(list):
	cards_in_deck.append_array(list)

func shuffle():
	cards_in_deck.shuffle()

func draw():
	var card_drawn:card = cards_in_deck.pop_back()
	if card_drawn == null:
		reshuffle()
		card_drawn = cards_in_deck.pop_back()

	if card_drawn != null:
		if card_drawn.card_type == 2:
			play_card_from_draw(card_drawn)
		elif hand.size() < 7:
			hand.append(card_drawn)
		else:
			discard_pile.append(card_drawn)

func reshuffle():
	cards_in_deck.append_array(discard_pile)
	discard_pile.clear()
	self.shuffle()

func put_card_on_top(place_card:card):
	cards_in_deck.push_back(place_card)

func put_card_on_bottom(place_card:card):
	cards_in_deck.push_front(place_card)

func play_card(hand_index:int):
	var card_played:card = hand.pop_at(hand_index)
	discard_pile.push_back(card_played)
	return card_played

func add_card(c:card):
	discard_pile.push_back(c)

func add_card_to_deck(c:card):
	cards_in_deck.push_back(c)
	shuffle()
func reset_deck():
	cards_in_deck.append_array (hand)
	cards_in_deck.append_array (discard_pile)
	hand.clear()
	discard_pile.clear()

func discard(i:int):
	for x in range(i):
		var card_played:card = hand.pop_front()
		discard_pile.push_back(card_played)
		print("discarded")
func remove(i:int):
	for x in range(i):
		hand.remove_at (0)
		
func play_card_from_draw(card_to_play: card):
	if card_to_play.card_type == 2:
		var index = hand.find(card_to_play)
		if index >= 0:
			play_card(index)
