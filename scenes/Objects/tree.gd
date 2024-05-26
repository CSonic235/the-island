extends GameObject


func _ready():
	super()
	print("is tree")
	type  =object_type.TREE
	resource_amount = 3
	print(resource_amount)
	$Panel.hide()
	is_collidable = true
func display_info():
	$Panel.show()
func hide_info():
	$Panel.hide()