extends Label

func _process(delta: float) -> void:
	text = GlobalTime.time_to_string()
