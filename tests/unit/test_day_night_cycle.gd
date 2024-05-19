extends GutTest
var game = load('res://game_map/game_map.tscn')
func before_all():
	var instance = game.instantiate()
	get_tree().get_root ().add_child(instance)

func before_each():
	pass
func test_day_night_different():
	var instance = get_tree().root.get_node("GameMap")
	var day_and_night_cycle = instance.get_node("day_night_cycle")
	day_and_night_cycle.is_night  = false
	assert_eq(day_and_night_cycle.is_night, false, "it is day")
	var night_scene = instance.get_node("night_overlay") ## gets the node night overlay which currently does not exist
	if night_scene == null:
		fail_test("night overlay does not exist")
	else:
		var night_is_displayed = night_scene.visible ## checks if night overlay is visible or not
		assert_eq(night_is_displayed, false, "it is day and the nigt overlay is visible")## asserts if it is day that the night overlay is invivisble
		day_and_night_cycle.entershop() ## makes the gmae enter night time
		night_is_displayed = night_scene.visible
		assert_eq(night_is_displayed, true, "it is night and the night overlay is invisible")

func test_clock_symbol_UI():
	var game_map = get_tree().root.get_node("GameMap")
	var clock_symbol = game_map.get_node("Camera2D/UI/clock_symbol")
	if clock_symbol == null:
		fail_test("clock_symbol does not exist")
	else:
		var day_and_night_cycle = game_map.get_node("day_night_cycle")
		var time = day_and_night_cycle.totalgametime()
		## clock symbol is currently not an implemented class instead under UI we have the node label Time, this needs to be changed to clock symbol and the code to change time refactored.
		assert_eq(time, clock_symbol.get_displayed_time(), "game_time_is_inconsistent with clock time") 
		## clock symbol needs to have a function called get_displayed time which outputs the time the clock symbol is displaying
