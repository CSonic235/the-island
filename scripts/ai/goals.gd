extends Node

# Import the task and goal scripts
const FishingTask = preload("res://scripts/ai/fishing_task.gd")

# Define a list of goals
var goals: Array = []

# Initialize the goals
func _ready():
    goals.append(FishingTask.gather_food_goal)