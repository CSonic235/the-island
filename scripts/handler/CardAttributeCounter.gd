extends Node

signal static_attributes_counted(attributes_count: Dictionary)

func count_static_attributes(cards: Array[Card], card_id_to_count: int):
	var attributes_count = {
		"cold": 0,
		"wet": 0,
		"hot": 0,
		"windy": 0,
		"humid": 0,
		"dry": 0,
		"fish": 0,
		"fertile_soil": 0,
		"infertile_soil": 0
	}	

	for card in cards:
		if card.card_id == card_id_to_count:
			var static_attributes = card.static_attributes
			if static_attributes and "attributes" in static_attributes:
				var attributes = static_attributes["attributes"]
				for attribute in attributes:
					if attribute in attributes_count:
						attributes_count[attribute] += 1

	emit_signal("static_attributes_counted", attributes_count)

