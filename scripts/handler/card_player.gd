extends Node
signal affects_deck(attribute:Dictionary)
signal affects_world(attribute:Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_card(c:card):
	if c.card_type==0:
		var attributes = c.action_attributes
		if attributes.get("affects_deck"):
				affects_deck.emit(attributes.get("affects_deck"))
				print("affects_deck signal sent")
		elif  attributes.get("affects_world"):
				print(attributes.get("affects_world"))
				affects_world.emit(attributes.get("affects_world"))
				print(" affects_world signal sent")

