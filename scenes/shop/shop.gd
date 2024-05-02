extends Panel

@onready var shop_interface = $BoxContainer
@onready var show_shop_button = get_parent().find_children("show_shop")[0]
@onready var energy_display =  get_parent().find_children("energy_display")[0]
var display_card = preload("res://scenes/shop/shop_card.tscn")
var energy:int =5
var cards_possible:Array = create_possible_cards()
var cards_bought:Array 
# Called when the node enters the scene tree for the first time.
func _ready():
	show_shop_button.hide()
	
	energy_display.clear()
	energy_display.text = "Energy   "+str(energy)
	for x in range(2):
		for n in range(3):
			var card_to_add:card = pick_a_card()
			var card_instance = display_card.instantiate()
			card_instance.update_card_info(card_to_add)
			card_instance.move_local_x(n*220) 
			card_instance.move_local_y(x*290+10) 
			self.add_child(card_instance)
	self.hide()
	show_shop_button.show()

func buy_card(card_bought:shop_card):
	var cost:int = card_bought.cost
	if cost <= energy:
		energy -=cost
		energy_display.clear()
		energy_display.text = "Energy   "+str(energy)		
		card_bought.buy()
		cards_bought.append(card_bought.card_displayed)
	else:
		print("can't buy")




func _on_hide_button_pressed():
	self.hide()
	show_shop_button.show()


func _on_show_shop_pressed():
	self.show()
	show_shop_button.hide()

func pick_a_card():
	var rng = RandomNumberGenerator.new()
	var index =rng.randi_range(0, cards_possible.size()-1)
	print(cards_possible[index].get_class)
	return cards_possible[index]
func create_possible_cards():
	var file = "res://data/cards.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)

	var possible_cards:Array = []
	for c in json_as_dict:
		if c.in_shop:
			var rarity:int = c.rarity
			var card_to_add:card = card.new(c)
			for i in 4-rarity:
				possible_cards.append(card_to_add)
	return 	possible_cards