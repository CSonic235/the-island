extends Node
class_name Condition
var condition_name :String
var contition_type:String
var days_having_condition:int = 0
var is_negative_condition:bool = true
var is_stackable:bool
var stack_count:int 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init(name:String):
	condition_name = name