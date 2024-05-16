extends Node

signal static_attributes_counted(cold_count: int, wet_count: int)

func count_static_attributes(cards: Array[Card], card_id_to_count: int):
	var cold_count = 0
	var wet_count = 0
	var
	
	for card in cards:
		if card.card_id == card_id_to_count:
			var static_attributes = card.static_attributes
			if static_attributes and "attributes" in static_attributes:
				var attributes = static_attributes["attributes"]
				for attribute in attributes:
					if attribute == "cold":
						cold_count += 1
					elif attribute == "wet":
						wet_count += 1

	emit_signal("static_attributes_counted", cold_count, wet_count)

