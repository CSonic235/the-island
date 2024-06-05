extends Node
class_name harvest_timer
var harvest_progress:float = 1.00
var total_harvest_time_in_seconds:float = 5
var time_elasped:float =  0
var timer_paused:bool = false
signal timer_ended()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(time_to_harvest:float):
	total_harvest_time_in_seconds = time_to_harvest
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer_paused:
		time_elasped +=delta
		harvest_progress =(total_harvest_time_in_seconds- time_elasped)/total_harvest_time_in_seconds
		if harvest_progress <= 0:
			pause_timer()
			
			timer_ended.emit()
			
			
func pause_timer():
	timer_paused = true
func unpause_timer():
	timer_paused = false
func reset_timer():
	time_elasped = 0 
	unpause_timer()
