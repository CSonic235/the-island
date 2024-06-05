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
var target:Node = null
var at_target:bool = false
var moved_x  = false
var moved_y = false
@onready var sprite = $AnimatedSprite2D
var has_screen = false
var speed:int = 30
var harvesting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	input_pickable = true
	pick_a_sprite()
	sprite.play("front_idle")
	pass # Replace with function body.
	move_a_place()



func _process(_delta):
	check_conditions()
	if not is_dead:
		move_and_slide()
		if velocity == Vector2(0,0) and (harvesting == false):
			sprite.play("front_idle")
	else:
		$AnimatedSprite2D.play("dying")
		if sprite.get_frame() == 5:
			sprite.pause()
	
	if target != null and harvesting == false:
		move_to_target()
		if at_target ==true:
			move("Stop")
			harvest()
			harvesting = true

	if target == null:
		moved_x = false
		moved_y = false
		at_target = false
		harvesting = false		
		if velocity.y<=5 and velocity.x<=5:
			move_a_place()

func harvest():
	if target != null and at_target == true:
		target.harvest()
		sprite.play("working")
	else:
		moved_x = false
		moved_y = false
		at_target = false
		harvesting = false		


func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			get_parent().display_survivor_info(self)

func move_to_target():
	if at_target == false:
		if (target.global_position.x) <=self.global_position.x and moved_x == false :
			move("Left")
		elif (target.global_position.x) >=self.global_position.x :
			move("Right")
			moved_x = true
		elif (target.global_position.y) >= self.global_position.y and moved_y == false:
			move("Down")
		elif (target.global_position.y) <= self.global_position.y:
			move("Up")
			moved_y = true
		else:
			at_target = true
			

func move( direction: String):
	var anim = sprite
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

func pick_a_sprite():
	var rng = RandomNumberGenerator.new()
	var sprite_number = rng.randi_range(0,3)
	var sprite2 = load("res://survivor_2.tscn")
	var sprite3 = load("res://survivor_3.tscn")
	var sprite4 = load("res://survivor_4.tscn")
	var spritearray = [null,sprite2,sprite3,sprite4]
	if sprite_number >=1:
		var current_sprite = spritearray[sprite_number]
		var sprite_instance = current_sprite.instantiate()
		add_child(sprite_instance)
		sprite.queue_free()
		sprite = sprite_instance
func move_a_place():
	var rng = RandomNumberGenerator.new()
	var direction = rng.randi_range(0,3)
	match direction:
		0:
			move("Left")
		1:
			move("Right")
		2:
			move("Up")
		3:
			move("Down")
func _on_found_thing(body:Node2D):
	if target == null:
		target = body
		print("here")
		moved_x = false
		moved_y = false
		at_target = false
		harvesting = false

func _on_found_object_body_entered(body:Node2D):
	at_target = true
	target = body
	print("found")
	moved_x = false
	moved_y = false	
	harvesting = false

