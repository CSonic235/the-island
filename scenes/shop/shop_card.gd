extends Control

@onready var border_color = $border 
@onready var buy_button = $area2d/buy_button
# Called when the node enters the scene tree for the first time.
func _ready():
	border_color.hide()
	buy_button.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_color_mouse_exited():
	border_color.hide()


func _on_color_mouse_entered():
	border_color.show()









func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton and event.pressed:
		print("Mouse button pressed")


