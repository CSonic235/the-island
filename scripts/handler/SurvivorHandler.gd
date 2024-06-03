extends Control
class_name SurvivorHandler

var number_of_survivors: int = 5
var survivor_info_displayed: bool = false
var possible_survivors: Array = []
var survivorUI = preload("res://UI/survivorPanel.tscn")
var window = survivorUI.instantiate()
signal show_survivor_panel(s: Survivor)

# Called when the node enters the scene tree for the first time.
func _ready():
    number_of_survivors = get_parent().get_number_of_survivors()
    possible_survivors = create_possible_survivors()
    load_survivors(number_of_survivors)
    print("survivors loaded")
    if get_child_count() > 1:
        get_child(0).move("Up")
        get_child(1).move("Up")

func get_survivor(index: int):
    return get_child(index)

func load_survivors(amount: int):
    var survivor_scene = preload("res://survivor.tscn")
    for n in range(amount):
        var survivor_instance = create_survivor(survivor_scene)
        survivor_instance.move_local_x(n * 30)
        self.add_child(survivor_instance)

func create_survivor(survivor_scene):
    var rng = RandomNumberGenerator.new()
    if possible_survivors.size() > 0:
        var info_index = rng.randi_range(0, possible_survivors.size() - 1)
        var info = possible_survivors[info_index]
        possible_survivors.remove_at(info_index)
        var survivor_instance = survivor_scene.instantiate()

        if survivor_instance is Survivor:
            survivor_instance.update_details(info)
            return survivor_instance
        else:
            print("Error: Instanced node is not of type 'Survivor'")
            return null
    return null

func display_survivor_info(survivor: Survivor):
    show_survivor_panel.emit(survivor)

func set_has_screen():
    survivor_info_displayed = false

func create_possible_survivors():
    var file_path = "res://data/survivors.json"
    var file = FileAccess.open(file_path, FileAccess.READ)
    
    if not file:
        push_error("Failed to open file: " + file_path)
        return []
    
    var json_as_text = file.get_as_text()
    file.close()
    
    var json = JSON.new()
    var json_parse_result = json.parse(json_as_text)
    
    if json_parse_result != OK:
        push_error("Failed to parse JSON: " + str(json_parse_result) + " " + json.error_string)
        return []
    
    return json.get_data()
