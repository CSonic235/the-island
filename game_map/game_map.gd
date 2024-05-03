extends Node2D

var number_of_survivors:int = 8
@onready var UI_layer  = $Camera2D/UI

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("SurvivorHandler").show_survivor_panel.connect(_on_survivor_handler_show_survivor_panel)
	get_node("cards_handler").card_effect.connect(_on_affects_world)
	create_shop()


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