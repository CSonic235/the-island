extends Camera2D

const Active_area = 100


@export var zoom_in_limit := 2.0
@export var zoom_out_limit := 0.7
@export var zoom_speed := 1.25
@export var edge_area := 50
@export var move_speed := 200
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
		elif event.is_action_pressed("zoom_out"):
			zoom_level /= zoom_speed
		elif InputEventMouseButton and event.pressed and event.button_index == 2:
			initial_camera_pos = position
			drag_start = get_viewport().get_mouse_position()
			move_camera = true
		elif InputEventMouseButton and !event.pressed and event.button_index == 2:
			move_camera = false
		zoom_level = clamp(zoom_level, zoom_out_limit, zoom_in_limit)
		self.zoom = Vector2(zoom_level, zoom_level)
	if event is InputEventKey:
		if event.is_action_pressed("center_camera"):
			self.position = Vector2(0, 0)


func _process(delta):
	edge_movement(delta)

func edge_movement(delta):
	var screen_size = get_viewport().size
	var mouse_position = get_viewport().get_mouse_position()
	
	var move_vector = Vector2()
	
	
	if mouse_position.x < edge_area:
		move_vector.x -= 1
	elif mouse_position.x > screen_size.x - edge_area:
		move_vector.x += 1
	if mouse_position.y < edge_area:
		move_vector.y -= 1
	elif mouse_position.y > screen_size.y - edge_area:
		move_vector.y += 1
	if move_vector.length() > 0:
		move_vector = move_vector.normalized()
	
	position += move_vector * move_speed * delta
