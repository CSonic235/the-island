extends GameObject


func _ready():
	
	print("is tree")
	type  =object_type.TREE
	resource_amount = 3
	print(resource_amount)
	$Panel.hide()
	is_collidable = true
	super()
	$harvest_panel.hide()
func display_info():
	$Panel.show()
func hide_info():
	$Panel.hide()
func display_harvest_percentage():
	$harvest_panel.show()
	var percentage_text_box:RichTextLabel = get_node("harvest_panel/harvest percentage")
	percentage_text_box.text = str(int(timer.harvest_progress *100)) +"%"