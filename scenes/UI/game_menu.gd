extends Control
signal quit_game()



func _ready(): ## pauses the game when menu opens
	hide()



func _on_resume_game_button_pressed(): ## unpauses the game and closes the menu
	hide()
	get_tree().paused = false

func _on_exit_game_button_pressed():
	var main_menu = load("res://UI/MainMenu.tscn")
	get_tree().paused = false
	var menu_instance = main_menu.instantiate()
	print(menu_instance)
	get_tree().root.add_child(menu_instance)
	quit_game.emit()