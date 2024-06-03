extends Node


func _ready():
	var tree = preload("res://scenes/Objects/rock.tscn") 

	var object_instance = tree.instantiate()
	self.add_child(object_instance)
	object_instance.set_position( Vector2(900, 250)   )


