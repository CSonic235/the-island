extends GameObject


func _ready():
	$Panel.hide()
	$harvest_panel.hide()
	type  =object_type.FLOWER
	resource_amount = 4
	harvest_type = "Flower"
	$Panel.hide()
	time_to_harvest = 5.0
	is_collidable = false
	super()

func display_info():
	$Panel.show()
func hide_info():
	$Panel.hide()

func display_harvest_percentage():
	$harvest_panel.show()
	var percentage_text_box:RichTextLabel = get_node("harvest_panel/harvest percentage")
	percentage_text_box.text = str(int(timer.harvest_progress *100)) +"%"
