extends Node
class_name play_cards

# Called when the node enters the scene tree for the first time.


var cards_in_deck:Array[card] =[]
var discard_pile:Array[card] =[]
var hand:Array[card] =[]

func _init(list):
	cards_in_deck.append_array(list)

func shuffle():
	cards_in_deck.shuffle()

func draw():
	var card_drawn:card = cards_in_deck.pop_back ()
	if card_drawn ==null:
		reshuffle()
		card_drawn = cards_in_deck.pop_back ()

	hand.append(card_drawn)

func reshuffle():
	cards_in_deck.append_array(discard_pile)
	self.shuffle()

func put_card_on_top(place_card:card):
	cards_in_deck.push_back(place_card)

func put_card_on_bottom(place_card:card):
	cards_in_deck.push_front(place_card)

func play_card(hand_index:int):
	var card_played:card = hand.pop_at(hand_index)
	discard_pile.push_back(card_played)