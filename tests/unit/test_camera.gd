extends GutTest

const SCREEN_SIZE = Vector2(1152, 648)
const EDGE_AREA = 50
const MOVE_SPEED = 20

func test_edge_movement() -> void:

	var CameraScript = load("res://game_map/Camera2D.gd")
	var camera = CameraScript.new()
	camera.move_speed = MOVE_SPEED
	camera.edge_area = EDGE_AREA
	
	var viewport = get_viewport()
	viewport.size = SCREEN_SIZE
	viewport.add_child(camera)
	camera.get_viewport().size = SCREEN_SIZE
	
	var desired_mouse_position = Vector2(1000, 500)
	
	camera.position = Vector2()  
	camera._process(1.0) 
	var initial_position = camera.position
	camera.set_process_input(true) 
	simulate_mouse_movement(desired_mouse_position)
	await get_tree().process_frame 
	assert_true(camera.position.x < initial_position.x, "Camera should move left")
	
	reset_camera_and_mouse(camera)


func simulate_mouse_movement(position: Vector2) -> void:
	var mouse_delta = position - get_viewport().get_mouse_position()
	var mouse_motion = InputEventMouseMotion.new()
	mouse_motion.relative = mouse_delta
	Input.parse_input_event(mouse_motion)

func reset_camera_and_mouse(camera) -> void:
	camera.set_process_input(false)
	camera.position = Vector2.ZERO 
