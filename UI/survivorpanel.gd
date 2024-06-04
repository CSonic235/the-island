extends Panel

var survivor_name = ""
var is_hidden = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_button_pressed():
	self.hide()
	is_hidden = true
func show_panel():
	self.show()
	is_hidden = false
func change_name(newName:String):
	var nameBox = $Control/name
	nameBox.clear()
	nameBox.append_text(newName)
func panel_is_hidden():
	return is_hidden

func update_info(survivor:Survivor):
	var name_box = $Control/name
	var info_box = $Control/info
	name_box.clear()
	info_box.clear()
	name_box.append_text(survivor.get_survivor_name())
	info_box.append_text("Movement speed: "+str(survivor.base_movement_speed))
	info_box.append_text("\nCarrying capacity: "+str(survivor.carrying_capacity))
