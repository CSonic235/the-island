extends Panel

var number_of_survivors :int =5
# Called when the node enters the scene tree for the first time.
func _ready():
	var number_of_survivors_button = get_child(0).get_child(0)
	number_of_survivors_button.select (4)





func _on_option_button_item_selected(index:int):
	number_of_survivors =  index +1


func _on_button_pressed():
	
	var game = load("res://game_map/game_map.tscn")
	var game_instance = game.instantiate()
	game_instance.set_number_of_survivors(number_of_survivors)
	get_tree().root.add_child(game_instance)
	get_tree().change_scene_to_packed(game_instance)
	print("starting game with ",number_of_survivors," survivors"  )
	self.get_parent().queue_free()
