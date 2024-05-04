extends Node2D


@onready var name_box = $color/card_name
@onready var description_box = $color/ColorRect/card_description

var card_name: String = ""
var description: String = ""
var card_displayed:card
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	
	change_display()

func change_display_test():
	
	print("name_box:", name_box)
	print("description_box:", description_box)

	name_box.text = card_name
	description_box.bbcode_text = description
	
func update_card_info(c:card):
	card_name= c.card_name
	description = c.card_description
	card_displayed = c
	
func change_display():
	description_box.clear()
	description_box.add_text(description)
	name_box.text = card_name


func _on_Area2D_mouse_entered():
	animation_player.play("Select")


func _on_Area2D_mouse_exited():
	animation_player.play("DeSelect")