extends Resource
class_name Goal

@export var goal_name: String
@export var priority: int
@export var tasks: Array = []

func initialize(goal_name: String, goal_priority: int, task_list: Array):
    self.goal_name = goal_name
    self.priority = goal_priority
    self.tasks = task_list
