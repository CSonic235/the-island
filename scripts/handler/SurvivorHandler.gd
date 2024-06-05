extends Control
class_name SurvivorHandler
var number_of_survivors:int = 5
var survivor_info_displayed:bool = false
var possible_survivors:Array = create_possible_survivors()
var survivorUI = preload("res://UI/survivorPanel.tscn")
var window = survivorUI.instantiate()
signal show_survivor_panel(s:Survivor)
# Called when the node enters the scene tree for the first time.
func _ready():
	number_of_survivors = get_parent().get_number_of_survivors()
	self.load_survivors(number_of_survivors)
	print("survivors loaded")




func get_survivor(index:int):
	return get_child(index)

''' func set_number_of_survivors(amount:int):
	number_of_survivors = amount '''

func load_survivors(amount :int):
	var survivor = preload("res://survivor.tscn") 
	for n in range(amount):
		
		var survivor_instance = create_survivor(survivor)
		survivor_instance.move_local_x(n*30) 
		self.add_child(survivor_instance)
func create_survivor(survivor):
	var rng = RandomNumberGenerator.new()
	if ! possible_survivors.is_empty():
		var info_index =rng.randi_range(0, possible_survivors.size()-1)
		var info = possible_survivors[info_index]
		possible_survivors.remove_at(info_index)
		var survivor_instance = survivor.instantiate()
		survivor_instance.update_details(info)
		return survivor_instance
func display_survivor_info(survivor :Survivor):
	show_survivor_panel.emit(survivor)
		

func set_has_screen():
	survivor_info_displayed = false

func create_possible_survivors():
	var file = "data\\survivors.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	return 	json_as_dict

