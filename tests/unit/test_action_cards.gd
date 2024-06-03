extends GutTest

func _test_count_action_cards():
	# Open the JSON file using FileAccess
	var json_file = FileAccess.open("res://data/cards.json", FileAccess.READ)
	
	if json_file:
		# Read the entire content of the file as text
		var data = json_file.get_as_text()
		
		# Close the file (not strictly necessary as FileAccess handles it automatically, but good practice)
		json_file.close()
		
		# Parse the JSON data
		var json = JSON.new()
		var parsed_data = json.parse(data)

		if parsed_data.error != OK:
			assert_true(false, "Failed to parse JSON data")
			return
		
		var cards = parsed_data.result
		
		# Count the number of action cards
		var action_card_count = 0
		for card_type in cards:
			if card_type["card_type"] == "action_card":
				action_card_count += 1
		
		assert_true(action_card_count > 10, "There should be more than 10 action cards in the deck.")
	else:
		assert_true(false, "JSON file not found")

# Variables to check signal emissions
var effect_world_emitted = false
var effect_deck_emitted = false

# Signal handlers
func _on_effect_world():
	effect_world_emitted = true
	
func _on_effect_deck():
	effect_deck_emitted = true

func _test_action_card_signals():
	const CardScript = preload("res://classes/card.gd")
	const CardType = CardScript.CardType

	# Create an action card
	var action_card = CardScript.new({
		"card_name": "Test Action Card",
		"card_type": CardType.action_card,
		"card_description": "This is a test action card.",
		"image_path": "res://path/to/image.png",
		"rarity": CardScript.Rarity.common,
		"cost": 1,
		"card_id": 1,
		"in_shop": false,
		"action_attributes": {}
	})
	
	# Connect signals to test functions
	action_card.connect("effect_world", Callable(self, "_on_effect_world"))
	action_card.connect("effect_deck", Callable(self, "_on_effect_deck"))
	
	# Play the card
	action_card.play()
	
	# Assert that the signals were emitted
	assert_true(effect_world_emitted, "effect_world signal should be emitted")
	assert_true(effect_deck_emitted, "effect_deck signal should be emitted")
