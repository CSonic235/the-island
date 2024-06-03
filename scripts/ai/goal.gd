extends Resource
class_name Goal

func _init(name: String, priority: int, tasks: Array):
    self.name = name
    self.priority = priority
    self.tasks = tasks
