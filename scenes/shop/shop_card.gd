extends Node2D
class_name shop_card
@onready var border_color = $border 
@onready var buy_button = $area2d/buy_button
@onready var name_box = $color/card_name
@onready var cost_box = $color/card_cost
@onready var description_box = $color/ColorRect/card_description
var card_displayed:card
var card_name:String = "card_name"
var cost:int = 2
var description:String ="description"
# Called when the node enters the scene tree for the first time.
func _ready():
	border_color.hide()
	buy_button.hide()
	change_display()


func __init(c:card):
	card_displayed = c

func buy():
	$area2d.hide()
	$color.hide()
	border_color.show()
	
func update_card_info(c:card):
	card_name= c.card_name
	description = c.card_description
	cost = c.cost

func change_display():
	description_box.clear()
	description_box.add_text(description)
	name_box.text = card_name
	cost_box.text = str(cost)


func _on_area_2d_mouse_entered(): 
	border_color.show()
	buy_button.show()

func _on_area_2d_mouse_exited(): 
	border_color.hide()
	buy_button.hide()

func _on_buy_button_pressed():
	$area2d.hide()
	$color.hide()
	border_color.show()
