extends Node

# Define a fishing task
var gather_bamboo = Task.new("Gather Bamboo", [], Callable(self, "gather_bamboo_action"))
var make_fishing_rod = Task.new("Make Fishing Rod", [gather_bamboo], Callable(self, "make_fishing_rod_action"))
var fish = Task.new("Fish", [make_fishing_rod], Callable(self, "fish_action"))

# Define a goal
var gather_food_goal = Goal.new("Gather Food", 10, [fish])