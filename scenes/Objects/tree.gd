extends GameObject


func _ready():
	
	type  =object_type.TREE
	resource_amount = 3
	$Panel.hide()
	is_collidable = true
	$harvest_panel.hide()
	time_to_harvest = 15.0
	super()

func display_info():
	$Panel.show()
func hide_info():
	$Panel.hide()
func display_harvest_percentage():
	$harvest_panel.show()
	var percentage_text_box:RichTextLabel = get_node("harvest_panel/harvest percentage")
	percentage_text_box.text = str(int(timer.harvest_progress *100)) +"%"