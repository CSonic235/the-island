extends Node 
class_name DayNightCycle

signal day_ends

var time_passed = 0
var one_day_duration = 60.0  
var is_night = false
var dayingame=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta
	if time_passed >= one_day_duration:
		time_passed = 0
		dayingame += 1
		entershop()
	
func timer():
	return one_day_duration-time_passed

func get_dayingame():
	return dayingame

func get_dayornight():
	return is_night

func totalgametime():
	return dayingame+"m"+time_passed+"s"

func entershop():
	day_ends.emit()

