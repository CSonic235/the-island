extends Node

var gather_bamboo: Task
var make_fishing_rod: Task
var fish: Task
var gather_food_goal: Goal

func _init():
    gather_bamboo = Task.new("Gather Bamboo", [], Callable(self, "gather_bamboo_action"))
    make_fishing_rod = Task.new("Make Fishing Rod", [gather_bamboo], Callable(self, "make_fishing_rod_action"))
    fish = Task.new("Fish", [make_fishing_rod], Callable(self, "fish_action"))

    gather_food_goal = Goal.new("Gather Food", 10, [fish])

# Dummy actions to avoid errors
func gather_bamboo_action():
    return true

func make_fishing_rod_action():
    return true

func fish_action():
    return true