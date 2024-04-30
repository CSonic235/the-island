extends Panel

@onready var shop_interface = $BoxContainer
var shop_card = preload("res://scenes/shop/shop_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(2):
		for n in range(3):
			var card_instance = shop_card.instantiate()
			card_instance.move_local_x(n*220) 
			card_instance.move_local_y(x*280+30) 
			self.add_child(card_instance)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


