extends CharacterBody2D
class_name Survivor
var  survivor_Name = "Steve"
var carrying_capacity :float =10
var carry_multiplier:float =1
var base_movement_speed:float = 30
var movement_multiplier:float = 1
var backstory:String = ""
var conditions:Array = []
var is_dead :bool = false
var working:bool = false

var has_screen = false
var speed:int = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	input_pickable = true
	$AnimatedSprite2D.play("front_idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_conditions()
	if not is_dead:
		move_and_slide()
		if velocity == Vector2(0,0):
			$AnimatedSprite2D.play("front_idle")
	else:
		$AnimatedSprite2D.play("dying")
		if $AnimatedSprite2D.get_frame() == 5:
			$AnimatedSprite2D.pause()
		


func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			get_parent().display_survivor_info(self)
		

func move( direction: String):
	var anim = $AnimatedSprite2D
	match direction:
		"Left":
				velocity.x = -base_movement_speed
				velocity.y = 0		
				anim.flip_h = true
				anim.play("side_walk")	
		"Right":
				velocity.x = base_movement_speed
				velocity.y = 0
				anim.flip_h = false
				anim.play("side_walk")
		"Up":
				velocity.x = 0
				velocity.y = -base_movement_speed	
				anim.flip_h = false
				anim.play("back_walk")
		"Down":
				velocity.x = 0
				velocity.y = base_movement_speed
				anim.flip_h = false
				anim.play("front_walk")
		"Stop":
				velocity.x = 0
				velocity.y = 0		
				anim.flip_h = false
				if working:
					anim.play("working")
				else:
					anim.play("front_idle")
	
	
func set_has_screen():
	has_screen = false

func get_survivor_name():
	return survivor_Name

func update_details(info:Dictionary):
	survivor_Name = info.get("name")
	carrying_capacity  =info.get("carrying_capacity")
	base_movement_speed =info.get("movement_speed")
	backstory = info.get("backstory")

func add_condition(condition:Condition):
	conditions.append(condition)

func check_conditions():
	
	for x in conditions:
		var condition:String = x.condition_name
		match condition:
			"dehydrated":
				if x.stack_count ==3:
					is_dead = true
			"malnutritioned":
				if x.stack_count == 7:
					is_dead = true
			"leg_wound":
				movement_multiplier = 0.75*x.stack_count
			"arm_wound":
				carry_multiplier = 0.75*x.stack_count
				