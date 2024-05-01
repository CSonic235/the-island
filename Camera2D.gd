extends Camera2D

const Active_area = 100


@export var zoom_in_limit := 2.0
@export var zoom_out_limit := 0.5
@export var zoom_speed := 1.25

var zoom_level = 1.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var _target = event.position - get_viewport().size * 0.5
		if _target.length() < Active_area:
			self.position = Vector2(0, 0)
		else:
			self.position = _target.normalized() * (_target.length() - Active_area) * 0.5

	if event is InputEventKey:
		if event.is_action_pressed("zoom_in"):
			zoom_level *= zoom_speed
		elif event.is_action_pressed("zoom_out"):
			zoom_level /= zoom_speed

		zoom_level = clamp(zoom_level, zoom_out_limit, zoom_in_limit)
		$Camera2D.zoom = Vector2(zoom_level, zoom_level)
