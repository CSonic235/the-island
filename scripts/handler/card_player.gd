extends Node
signal affects_deck
signal affects_world

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_card(c:card):
	if c.card_type==0:
		var attributes = c.action_attributes
		if c.action_attributes.get("affects_deck"):
				affects_deck.emit(attributes)
		elif  c.action_attributes.get( "affects_world"):
				affects_world.emit(attributes)