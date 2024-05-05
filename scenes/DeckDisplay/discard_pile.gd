extends Control
@onready var display_text = $Panel/display
# Called when the node enters the scene tree for the first time.
func _ready():
	test(5) # Replace with function body.
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(discard_array):
	display_text.clear()
	for c in discard_array:
		display_text.add_text(str(c)+"\n")


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
