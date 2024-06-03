extends Node2D


@onready var add_button = $add_button
@onready var name_box = $color/card_name
@onready var description_box = $color/ColorRect/card_description
var card_displayed:card
var card_name:String = "card_name"
var description:String ="description"
# Called when the node enters the scene tree for the first time.
func _ready():

	change_display()

func __init(c:card):
	card_displayed = c

func add_card():
	$color.hide()

func update_card_info(c:card):
	card_name= c.card_name
	description = c.card_description
	card_displayed = c
func change_display():
	description_box.clear()
	description_box.add_text(description)
	name_box.text = card_name

func _on_button_pressed():
	add_card()
