extends Node2D

var number_of_survivors:int = 8
@onready var UI_layer  = $Camera2D/UI
var time:String
@onready var time_label = $Camera2D/UI/Time
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("SurvivorHandler").show_survivor_panel.connect(_on_survivor_handler_show_survivor_panel)
	get_node("cards_handler").card_effect.connect(_on_affects_world)
	get_node("day_night_cycle").day_ends.connect(_on_day_ended)
	get_node("cards_handler").cards_changed.connect(_on_card_player_changed)
	get_node("Camera2D/pause_UI/Game_menu").quit_game.connect(_on_game_quit)
	

func _process(_delta):
	time = $day_night_cycle.totalgametime()
	time_label.text = time
	
func set_number_of_survivors(amount:int):
	number_of_survivors = amount
	print("amount of survivors set")
func get_number_of_survivors():
	
	return self.number_of_survivors

func create_shop():
	UI_layer.create_shop()


func _on_survivor_handler_show_survivor_panel(s:Survivor):
	UI_layer.display_survivor_info(s)

func _on_affects_world(d:Dictionary):
	print("signal recieved",d)

func _on_day_ended():
	create_shop()

func _on_button_pressed():
	var cards_bought = UI_layer.get_cards_bought()
	$cards_handler.night_actions(cards_bought)

	UI_layer.get_node("shop").queue_free()
	$day_night_cycle.unpause()
	UI_layer.get_node("next_day_button").hide()

func _on_card_player_changed(cards:play_cards):
	$Camera2D/UI/CardHand.update_hand(cards.hand)
	$Camera2D/UI/discard_pile.update(cards)

func _on_game_quit():
	self.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_menu"):
		get_tree().paused = true
		$Camera2D/pause_UI/Game_menu.show()