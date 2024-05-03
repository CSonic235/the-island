extends Control

var card_width = 250
var card_height = 320
var spacing = 20
var card_hand = []

func _ready():
	var json_file_path = "res://data/cards.json"
	var json_file = ResourceLoader.load(json_file_path)

	if json_file:
		var json_as_text = json_file.get_as_text()
		var json_as_dict = parse_json(json_as_text)

		var selected_cards = []
		var rng = RandomNumberGenerator.new()
		rng.randomize() 
		for i in range(6):
			var index = rng.randi_range(0, json_as_dict.size() - 1)
			selected_cards.append(json_as_dict[index])

		for i in range(selected_cards.size()):
			var card_instance = load("res://path_to_card_scene.tscn").instance() 
			card_instance.update_card_info(selected_cards[i]) 
			card_instance.rect_min_size = Vector2(card_width, card_height)
			card_instance.rect_position = Vector2(i * (card_width + spacing), 0) 
			add_child(card_instance) 
			card_hand.append(card_instance)


	else:
		print("JSON file not found:", json_file_path)

func parse_json(json_string):
	var json_parser = JSON.new()
	var json_error = json_parser.parse(json_string)
	if json_error != OK:
		print("Error parsing JSON:", json_error)
		return {}
	return json_parser.get_data()

func _on_button_pressed():
	self.show()
