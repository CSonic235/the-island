extends CanvasLayer

var survivorUI = preload("res://UI/survivorPanel.tscn")
var window = survivorUI.instantiate()

var survivor_info_displayed:bool = false
var shop = preload("res://scenes/shop/shop.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(window)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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