extends Node2D

var card_name_label: Label
var card_width: int = 250
var card_height: int = 320


func _ready():

	card_name_label = $card_name
	set_scale(Vector2(card_width / card_name_label.rect_size.x, card_height / card_name_label.rect_size.y))


func update_card_info(card_data: Dictionary):
	
	var card_name = card_data["name"]
	card_name_label.text = card_name


func _on_area_2d_mouse_entered():
	$AnimationPlayer.play("Select")

func _on_area_2d_mouse_exited():
	$AnimationPlayer.play("DeSelect")
