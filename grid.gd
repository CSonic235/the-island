extends Node2D

const TILE_COUNT = 1000

func _ready():
	var grid_radius = calculate_grid_radius(TILE_COUNT)
	var tiles = []
	for q in range(-grid_radius, grid_radius + 1):
		var r1 = max(-grid_radius, -q - grid_radius)
		var r2 = min(grid_radius, -q + grid_radius)
		for r in range(r1, r2 + 1):
			var tile_type = get_tile_type_based_on_position(q, r, grid_radius)
			var new_tile = Tile.new(tile_type, Vector2(q, r))  # create a new tile with type "tile_type"
			tiles.append(new_tile)
			add_child(new_tile)
			new_tile.setup_tile()
			print("Tile created at: ", new_tile.position, " with type: ",) # remove

func calculate_grid_radius(desired_tile_count):
	var current_tile_count = 1  # centre tile
	var radius = 0
	while current_tile_count < desired_tile_count:
		radius += 1
		current_tile_count += 6 * radius
	return radius

func get_tile_type_based_on_position(q, r, max_radius):
	var distance = abs(q) + abs(r)  # sum of absolute values for distance from centre of map
	var max_distance = 2 * max_radius  # max distance possible in the grid

	# define thresholds for different tile types
	var mountains_threshold = max_radius * 0.25  # 25% of the radius
	var grass_threshold = max_radius * 0.5      # 50% of the radius
	var sand_threshold = max_radius * 0.75      # 75% of the radius

	# assign tile type based on the distance
	if distance <= mountains_threshold:
		return Tile.TileTypes.MOUNTAINS
	elif distance <= grass_threshold:
		return Tile.TileTypes.GRASS
	elif distance <= sand_threshold:
		return Tile.TileTypes.SAND
	else:
		return Tile.TileTypes.WATER
