extends GutTest

func _before_each():
	var survivor = load("res://survivor.tscn").instance()

func test_survivor_can_move():
	var initial_position = survivor.position
	var update_position = Vector2(6,6)

	survivor.move(update_position)

	var new_position = survivor.position
	assert_not_equal(initial_position, new_position, "Survivor moved")

func test_survivor_can_carry
	var resource = "wood"
	survivor.carry_resource(resource)

	assert_true(survivor.is_carrying_resource(resource), "Survivor is carrying resource")
  
func test_resource_quantity():
	survivor.add_resource("wood", 5)   # assum that an add_resource function to add resource in survivor's package
	survivor.add_resource("food", 3)

	var num_wood = survivor.carry_resource_quantity("wood")
	var num_food = survivor.carry_resource_quantity("food")

	assert_equal(num_wood, 5, "Correct quantity of wood in survivor's package")
	assert_equal(num_food, 3, "Correct quantity of food in survivor's package")

func test_survivor_priority():
	# assuming if survivor's priority is to escape from the island if wood quantity is greater than food quantity
	# assuming if survivor's priority is to survive on the island if food quantity is greater than wood quantity

	var num_wood = survivor.carry_resource_quantity("wood")
	var num_food = survivor.carry_resource_quantity("food")

	assert_true(num_wood > num_food, "Survivor's priority is to escape")

