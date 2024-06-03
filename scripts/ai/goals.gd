extends Node

# Import the task and goal scripts
const FishingTaskScript = preload("res://scripts/ai/fishing_task.gd")

# Define a list of goals
var goals: Array = []

# Initialize the goals
func _ready():
    var fishing_task_instance = FishingTaskScript.new()
    goals.append(fishing_task_instance.gather_food_goal)