extends Node2D
class_name Tile
# tile properties
enum TileTypes { WATER, GRASS, MOUNTAINS, SAND }
var tile_type : int = TileTypes.GRASS
var is_passable : bool = true # can a survivor walk on this tile? 

func _init(p_type : int, p_position : Vector2):
	var type = p_type
	position = p_position

func setup_tile():
	match tile_type:
		TileTypes.WATER:
			is_passable = false
			load_visual("res://path/to/water_texture.png")
		TileTypes.GRASS:
			is_passable = true
			decide_trees()
			load_visual("res://path/to/grass_texture.png")
		TileTypes.MOUNTAINS:
			is_passable = false
			load_visual("res://path/to/mountain_texture.png")
		TileTypes.SAND:
			is_passable = true
			load_visual("res://path/to/sand_texture.png")

func decide_trees():
	# Give a 25% chance for trees to generate on this grass tile
	var has_trees = randf() < 0.25
	if has_trees:
		add_trees()  # Add trees if decided

func add_trees():
	# Function to handle the addition of trees, e.g., changing the visual
	var tree_sprite = Sprite2D.new()
	tree_sprite.texture = load("res://path/to/tree_texture.png")
	add_child(tree_sprite)
	tree_sprite.position = Vector2(0, 0)  # Center the tree sprite on the tile

func load_visual(texture_path):
	var sprite = $Sprite  # Assuming there's a Sprite node as a child of Tile
''' 	sprite.texture = load(texture_path) '''
