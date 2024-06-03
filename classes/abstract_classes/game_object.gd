extends AnimatableBody2D
class_name GameObject
var resource_amount:int
var is_harvestable:bool
enum object_type  {TREE,ROCK,BUSH,FLOWER,WELL,TEMPLE}
var type:object_type
var harvest_type:String
var is_collidable:bool = true
var time_to_harvest:float = 5.00
@onready var timer:harvest_timer  = harvest_timer.new(time_to_harvest)
var harvesting :bool = false
signal object_harvested(resource_type:String,resource_amount:int)

func _ready():
	input_pickable = true
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	timer.pause_timer()
	add_child(timer)
	timer.timer_ended.connect(_on_harvest_timer_completed)
	set_collision_layer_value ( 1, is_collidable) # makes the object collidable if is_collidable is true
func _process(_delta):
	if harvesting and timer.timer_paused:
		timer.unpause_timer()
	if timer.harvest_progress != 1.00:
		display_harvest_percentage()
func _on_mouse_entered():
	
	display_info()

func _on_mouse_exited():
	
	hide_info()

func _on_harvest_timer_completed():
	harvesting = false
	object_harvested.emit(harvest_type,resource_amount)
	self.queue_free()
func display_info():
	#"abstract method does nothing unless overrided(gdscript does not have interfaces)"
	pass

func hide_info():
	#"abstract method does nothing unless overrided(gdscript does not have interfaces)"
	pass
func display_harvest_percentage():
	#"abstract method does nothing unless overrided(gdscript does not have interfaces)"
	pass

func harvest():
	harvesting = true

