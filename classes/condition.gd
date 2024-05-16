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


func _init(n:String):
	self.condition_name = n
