extends Node
enum weather  {SUNNY, CLOUDY, STORM,RAIN ,HARSHSUN,POURINGRAIN}
var current_weather:weather = weather.SUNNY
var static_attributes:Dictionary = {"windy":2,"hot":1,"wet":1}
var weather_distribution = [weather.SUNNY,weather.CLOUDY,weather.CLOUDY,weather.RAIN]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_static_attribues(new_dictionary:Dictionary):
	static_attributes = new_dictionary

func update_weather_distribution():
	var new_weather_distribution:Array = []
	if static_attributes.has("hot"):
		var hot_value = static_attributes.get("hot")
		for x in range (hot_value):
			new_weather_distribution.append(weather.SUNNY)
		if hot_value >= 4:
			for x in range(hot_value-3):
				new_weather_distribution.append(weather.HARSHSUN)
	if static_attributes.has("windy"):
		var windy_value = static_attributes.get("windy")
		for x in range (windy_value):
			new_weather_distribution.append(weather.CLOUDY)
	if static_attributes.has("wet"):
		var wet_value = static_attributes.get("wet")
		for x in range (wet_value):
			new_weather_distribution.append(weather.RAIN)
		if wet_value >= 4:
			for x in range(wet_value-3):
				new_weather_distribution.append(weather.POURINGRAIN)		
	if static_attributes.has("moist") and static_attributes.has("wet") and static_attributes.has("windy"):
		var wet_value = static_attributes.get("wet")
		var moist_value = static_attributes.get("moist")
		var windy_value = static_attributes.get("windy")
		if (wet_value>3)and (moist_value>3)and (windy_value>4):
			for x in range (wet_value):
				new_weather_distribution.append(weather.STORM)
		weather_distribution = 	new_weather_distribution

func calculate_weather():
	var random_number:int
	if weather_distribution.size() !=0:
		random_number = rng.randi_range(0,weather_distribution.size()-1)
		current_weather = weather_distribution[random_number]
	else:
		current_weather = weather.SUNNY
		print("error weather_distribution is empty")
	print(current_weather)

func get_weather():
	match current_weather:
		weather.SUNNY:
			return "Sunny"
		weather.CLOUDY:
			return "Cloudy"
		weather.STORM:
			return "storm"
		weather.RAIN:
			return "rain"
		weather.HARSHSUN:
			return "Harsh Sun"
		weather.POURINGRAIN:
			return "Pouring Rain"