extends AnimatableBody2D
class_name GameObject
var resource_amount:int
var is_harvestable:bool
enum object_type  {TREE,ROCK}
var type:object_type
var harvest_type
var is_collidable:bool

func _ready():
	input_pickable = true
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
func _on_mouse_entered():
	
	display_info()

func _on_mouse_exited():
	
	hide_info()

func display_info():
	#"abstract method odes nothing unless overrided(gdscript does not have interfaces)"
	pass

func hide_info():
	#"abstract method odes nothing unless overrided(gdscript does not have interfaces)"
	pass