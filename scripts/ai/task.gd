extends Resource
class_name Task

@export var task_name: String
@export var prerequisites: Array = []
@export var action: Callable

func initialize(task_name: String, prerequisites_list: Array, task_action: Callable):
    self.task_name = task_name
    self.prerequisites = prerequisites_list
    self.action = task_action
