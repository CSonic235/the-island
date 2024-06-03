extends GameObject


func _ready():
	$Panel.hide()
	$harvest_panel.hide()
	type  =object_type.TEMPLE
	resource_amount = 2
	harvest_type = "Faith"
	$Panel.hide()
	is_collidable = true
	time_to_harvest = 30.0
	super()

func display_info():
	$Panel.show()
func hide_info():
	$Panel.hide()

func display_harvest_percentage():
	$harvest_panel.show()
	var percentage_text_box:RichTextLabel = get_node("harvest_panel/harvest percentage")
	percentage_text_box.text = str(int(timer.harvest_progress *100)) +"%"
