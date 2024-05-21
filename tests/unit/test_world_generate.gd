extends GutTest

class_name test_world_generate

const TEST_RUNS = 5

#number of survivors
func count_survivors():
	var survivor_handler = get_node("/root/YourGameNode/SurvivorHandler")
	return survivor_handler.get_child_count()

# unique island layout
func get_island_layout_hash():
	var island = get_node("/root/YourGameNode/Island")
	var hash = ""
	for tile in island.get_children():
		hash += str(tile.position) + str(tile.tile_type)
	return hash.md5_text()

#objects spawned on the island
func count_objects():
	var island = get_node("/root/YourGameNode/Island")
	var object_count = 0
	for tile in island.get_children():
		object_count += tile.get_child_count()
	return object_count

#test number of survivors
func test_number_of_survivors():
	var Game
	var settings = {"number_of_survivors": 4}
	var game = Game.new()
	game.set_settings(settings)
	game.start()

	await game.game_started
	
	assert_eq(count_survivors(), 4, "number of survivors should match the settings")

#test layout different
func test_island_layout_variation():
	var layouts = []
	var Game
	
	for i in range(TEST_RUNS):
		var game = Game.new()
		game.start()
		
		await game.game_started
		
		var layout_hash = get_island_layout_hash()
		assert_false(layout_hash in layouts, "island layout should be different each time")
		layouts.append(layout_hash)

#test different amount of object
func test_objects_spawn_variation():
	var object_counts = []
	var Game
	
	for i in range(TEST_RUNS):
		var game = Game.new()
		game.start()
		
		await game.game_started
		
		var object_count = count_objects()
		assert_false(object_count in object_counts, "amount of objects spawned should be different each time")
		object_counts.append(object_count)

