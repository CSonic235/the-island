extends GutTest
var _possible_cards = []
var _play_area:play_cards
func before_all():
	var file = "res://data/cards.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)

	_possible_cards = []
	for c in json_as_dict:
		if c.in_shop:
			var rarity = c.rarity
			var card_to_add = card.new(c)
			for i in 4 - rarity:
				_possible_cards.append(card_to_add)

func before_each():
	var deck_size = 10
	var _cards_in_deck = []
	for i in range(deck_size):
		_cards_in_deck.append( _possible_cards[i])
	_play_area = play_cards.new(_cards_in_deck)
func test_draw_a_card():
	## checks that drawing a card puts a card from the deck into the hand
	_play_area.draw()
	assert_eq(_play_area.hand.size(), 1, "one card in hand")
	assert_eq(_play_area.cards_in_deck.size(), 9, "9 cards in deck")
	assert_eq(_play_area.discard_pile.size(), 0, "0 cards in discard")

func test_draw_past_hand_size():
	## checks that drawing a card when hand size is at max puts it in the discard pile
	var hand_size:int = 7
	for x in range(hand_size):
		_play_area.draw()
	_play_area.draw()
	assert_eq(_play_area.hand.size(), 7, "7 cards in hand")
	assert_eq(_play_area.cards_in_deck.size(), 2, "2 cards in deck")
	assert_eq(_play_area.discard_pile.size(), 1, "1 cards in discard")
func test_draw_from_empty_deck():
	 ## checks that drawing from an empty deck shuffle the discard pile back into the deck
	var deck_size:int = 10 
	for x in range(deck_size):
		_play_area.draw()
	_play_area.draw()
	assert_eq(_play_area.hand.size(), 7, "7 cards in hand")
	assert_eq(_play_area.cards_in_deck.size(), 2, "2 cards in deck")
	assert_eq(_play_area.discard_pile.size(), 1, "1 cards in discard")