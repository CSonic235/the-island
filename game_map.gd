extends Node2D

var number_of_survivors:int = 8
@onready var UI_layer  = $Camera2D/UI
var card_hand_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("SurvivorHandler").show_survivor_panel.connect(_on_survivor_handler_show_survivor_panel)
	create_shop()
	card_hand_instance = $UI/CardHand
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_number_of_survivors(amount:int):
	number_of_survivors = amount
	print("amount of survivors set")
func get_number_of_survivors():
	
	return self.number_of_survivors

func create_shop():
	UI_layer.create_shop()

func toggle_card_hand_visibility():
	if card_hand_instance:
		if card_hand_instance.is_visible():
			card_hand_instance.hide()
	else:
		card_hand_instance.show()


func _on_open_hand_button_pressed():
	toggle_card_hand_visibility()


func _on_hide_hand_button_pressed():
	toggle_card_hand_visibility()

func _on_survivor_handler_show_survivor_panel(s:Survivor):
	print("signal recieved")
	UI_layer.display_survivor_info(s)

