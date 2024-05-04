extends CanvasLayer

var survivorUI = preload("res://UI/survivorPanel.tscn")
var window = survivorUI.instantiate()
@onready var hand = $CardHand
var hand_showed:bool = false

var survivor_info_displayed:bool = false
var shop = preload("res://scenes/shop/shop.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	hand.hide()
	$next_day_button.hide()

func display_survivor_info(survivor :Survivor):
	print("displaying survivor info")
	if window.get_child(0).panel_is_hidden():
		window.get_child(0).show_panel()
	if survivor_info_displayed == false:
		

		window.get_child(0).update_info(survivor)
		add_child(window)
		survivor_info_displayed = true
	else:
		window.get_child(0).update_info(survivor)
		
func create_shop():
	var shopinstance = shop.instantiate()
	add_child(shopinstance)
	$next_day_button.show()
	return shopinstance
func get_cards_bought():
	return get_node("shop/shop_panel").get_cards_bought()
func _on_button_pressed():
	if hand_showed:
		hand.hide()
		hand_showed = false
		$show_hand_button.text = "Show Hand"
		
	else:
		hand.show()
		hand_showed = true
		$show_hand_button.text = "Hide Hand"
