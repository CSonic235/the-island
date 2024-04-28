extends CharacterBody2D
class_name Survivor
var  survivor_Name = "Steve"
var carrying_capacity :float =10
var movement_speed:float = 30
var backstory:String = ""

var has_screen = false
var speed:int = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	input_pickable = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	move_and_slide()



func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			get_parent().display_survivor_info(self)
		

func move( direction: String):

	match direction:
		"Left":
				velocity.x = -movement_speed
				velocity.y = 0			
		"Right":
				velocity.x = movement_speed
				velocity.y = 0
		"Up":
				velocity.x = 0
				velocity.y = movement_speed	
		"Down":
				velocity.x = 0
				velocity.y = -movement_speed
		"Stop":
				velocity.x = 0
				velocity.y = 0		
	
	
func set_has_screen():
	has_screen = false

func get_survivor_name():
	return survivor_Name

func update_details(info:Dictionary):
	survivor_Name = info.get("name")
	carrying_capacity  =info.get("carrying_capacity")
	movement_speed =info.get("movement_speed")
	backstory = info.get("backstory")