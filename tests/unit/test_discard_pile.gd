extends GutTest

const SCENE_PATH = "res://scenes/DeckDisplay/discard_pile.tscn"
var discard_pile_scene
func before_each():
   
	var discard_pile_scene = load(SCENE_PATH).instantiate()
	add_child(discard_pile_scene)
	discard_pile_scene.hide()


func test_show_discard_panel():
	discard_pile_scene._on_show_discard_button_pressed()
	assert_true(discard_pile_scene.visible, "Panel is visible")

