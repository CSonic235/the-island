extends Control
var game_start = preload("res://UI/mainMenuSettings.tscn")
var has_window:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.





func _on_button_pressed():
    if  ! has_window:
        var settings_window = game_start.instantiate()
        for x in get_children():
            x.hide()
        add_child(settings_window)
        has_window = true
        settings_window.show()
        
