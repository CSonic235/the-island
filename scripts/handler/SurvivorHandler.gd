extends Node2D
class_name SurvivorHandler
var number_of_survivors:int = 5
var survivor_info_displayed:bool = false
var possible_survivors:Array = create_possible_survivors()
var survivorUI = preload("res://UI/survivorPanel.tscn")
var window = survivorUI.instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	number_of_survivors = get_parent().get_number_of_survivors()
	self.load_survivors(number_of_survivors)
	print("survivors loaded")
	self.get_child(0).move("Right")
	self.get_child(1).is_dead = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
	if window.get_child(0).panel_is_hidden():
		window.get_child(0).show_panel()
	if survivor_info_displayed == false:
		

		window.get_child(0).update_info(survivor)
		add_child(window)
		survivor_info_displayed = true
	else:
		window.get_child(0).update_info(survivor)
		print(survivor.get_survivor_name())
		

func set_has_screen():
	survivor_info_displayed = false

func create_possible_survivors():
	var file = "data\\survivors.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	return 	json_as_dict

