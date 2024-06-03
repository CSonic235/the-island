extends Resource
class_name Task

func _init(name: String, prerequisites: Array, action: Callable):
    self.name = name
    self.prerequisites = prerequisites
    self.action = action