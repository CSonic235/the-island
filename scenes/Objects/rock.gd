extends GameObject


func _ready():
	super()
	print("is rock")
	resource_amount = 3
	print(resource_amount)
	$Panel.hide()

func display_info():
	$Panel.show()
func hide_info():
	$Panel.hide()