extends Node
var all_objects:Array 
var number_of_objects_to_spawn_lower_limit:int =175
var number_of_objects_to_spawn_upper_limit:int = 225
@onready var map = $TileMap
func _ready():
	load_all_objects()
	var spawn_objects:Array = []
	var rng = RandomNumberGenerator.new()
	var number_of_objects_to_spawn:int = rng.randi_range ( number_of_objects_to_spawn_lower_limit, number_of_objects_to_spawn_upper_limit)
	for x in range(number_of_objects_to_spawn):
		var index:int = rng.randi_range ( 0, all_objects.size()-1)
		var object_instance = all_objects[index].instantiate()
		
		var x_position:int = rng.randi_range ( -2000, 2000)
		var y_position:int = rng.randi_range ( -3000, 3000)
		var position = (Vector2(x_position, y_position))
		var map_coordinates = map.local_to_map(position)
		var tile_is_not_water:bool = map.get_cell_source_id(0,map_coordinates) !=3 #to make sure no spwans are on top of a water cell
		if map_coordinates not in spawn_objects and tile_is_not_water:
			spawn_objects.append(map_coordinates)
			self.add_child(object_instance)
			object_instance.set_position( map.map_to_local ( map_coordinates )   )

func load_all_objects():
	var file = "res://scenes/Objects/all_objects.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var path_list = JSON.parse_string(json_as_text)
	for path in path_list:
		var object = load(path)
		all_objects.append(object)
