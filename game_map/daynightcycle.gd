extends Node 
class_name DayNightCycle

signal day_ends

var time_passed = 0
var one_day_duration = 1
var is_night = false
var dayingame=1
var pause:bool = false

@onready var night_color = $Camera2D/World/night_color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !pause:
		time_passed += delta
		if time_passed >= one_day_duration :
			time_passed = 0
			dayingame += 1
			is_night = !is_night 
			pause = true
			entershop()
	
func timer():
	return one_day_duration-time_passed

func get_dayingame():
	return dayingame

func get_dayornight():
	return is_night

func totalgametime():
	if !pause:
		return "day "+str(dayingame)+" \n"+str(round(time_passed))+"s"
	else:
		return "day "+str(dayingame)+" \n"+"night"

func entershop():
	day_ends.emit()
func unpause():
	pause = false

