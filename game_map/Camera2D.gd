extends Camera2D

const Active_area = 100


@export var zoom_in_limit := 2.0
@export var zoom_out_limit := 0.5
@export var zoom_speed := 1.25
var move_camera :bool = false 
var zoom_level = 1.0
var initial_camera_pos : Vector2
var drag_start : Vector2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and move_camera:
		
		var drag_current = get_viewport().get_mouse_position()
		var drag_delta = drag_current - drag_start
		self.position = initial_camera_pos - drag_delta

	if event is InputEventMouseButton:
		if event.is_action_pressed("zoom_in"):
			zoom_level *= zoom_speed
			print("zooming in")
		elif event.is_action_pressed("zoom_out"):
			zoom_level /= zoom_speed
			print("zooming out")
		elif InputEventMouseButton and event.pressed and event.button_index == 2:
			initial_camera_pos = position
			drag_start = get_viewport().get_mouse_position()
			print("pressed right button")
			move_camera = true
		elif InputEventMouseButton and !event.pressed and event.button_index == 2:
			print("released right button")
			move_camera = false
		zoom_level = clamp(zoom_level, zoom_out_limit, zoom_in_limit)
		self.zoom = Vector2(zoom_level, zoom_level)
	if event is InputEventKey:
		if event.is_action_pressed("center_camera"):
			self.position = Vector2(0, 0)
