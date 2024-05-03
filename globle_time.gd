extends Node

var global_time :=.0

var full_cycle_hour := 60
var full_cycle_day :=24

var day: int
var hour : int 
var minute : int 
var time_state : String

func _process(delta: float) -> void:
	var time_scale = 1 / full_cycle_hour
	
	if global_time <=1:
		global_time += delta * time_scale
		minute = full_cycle_hour * global_time
		
	if minute >= full_cycle_hour:
		hour +=1
		minute=0
		global_time=0
		
	if hour >= full_cycle_day:
		day += 1
		hour = 0
		
func time_to_string() -> String:
	return "Day " + String.num(day) + "/n" + String.num(hour) + "/n" + String.num(minute) + "/n"
