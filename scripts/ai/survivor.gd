extends CharacterBody2D
class_name Survivor

const GoalsScript = preload("res://scripts/ai/goals.gd")

var survivor_Name = "Steve"
var carrying_capacity: float = 10
var carry_multiplier: float = 1
var base_movement_speed: float = 30
var movement_multiplier: float = 1
var backstory: String = ""
var conditions: Array = []
var is_dead: bool = false
var working: bool = false

var has_screen = false
var speed: int = 30

# Needs
var thirst: float = 100
var hunger: float = 100
var sleep: float = 100
var desire_to_escape: float = 100
var recreation: float = 100
var socialisation: float = 100

# Depletion rates
const THIRST_DEPLETION_RATE: float = 50
const HUNGER_DEPLETION_RATE: float = 25
const SLEEP_DEPLETION_RATE: float = 50
const RECREATION_DEPLETION_RATE: float = 12.5
const SOCIALISATION_DEPLETION_RATE: float = 12.5

# Resource consumption rates (units per day)
var water_consumption_rate: float = 2.0
var food_consumption_rate: float = 1.5

# Current stockpiles
var water_stockpile: float = 100
var food_stockpile: float = 100

# Goals
var goals: Array = []
var current_goal: Goal = null
var current_task: Task = null

# Called when the node enters the scene tree for the first time.
func _ready():
    input_pickable = true
    $AnimatedSprite2D.play("front_idle")
    
    # Load the goals from the goals script
    goals = GoalsScript.goals
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    check_conditions()
    update_needs(_delta)
    update_resource_consumption(_delta)
    if not is_dead:
        evaluate_goals()
        execute_current_task()
        move_and_slide()
        if velocity == Vector2(0, 0):
            $AnimatedSprite2D.play("front_idle")
    else:
        $AnimatedSprite2D.play("dying")
        if $AnimatedSprite2D.get_frame() == 5:
            $AnimatedSprite2D.pause()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == 1:
            get_parent().display_survivor_info(self)

func move(direction: String):
    var anim = $AnimatedSprite2D
    match direction:
        "Left":
            velocity.x = -base_movement_speed
            velocity.y = 0
            anim.flip_h = true
            anim.play("side_walk")
        "Right":
            velocity.x = base_movement_speed
            velocity.y = 0
            anim.flip_h = false
            anim.play("side_walk")
        "Up":
            velocity.x = 0
            velocity.y = -base_movement_speed
            anim.flip_h = false
            anim.play("back_walk")
        "Down":
            velocity.x = 0
            velocity.y = base_movement_speed
            anim.flip_h = false
            anim.play("front_walk")
        "Stop":
            velocity.x = 0
            velocity.y = 0
            anim.flip_h = false
            if working:
                anim.play("working")
            else:
                anim.play("front_idle")

func set_has_screen():
    has_screen = false

func get_survivor_name():
    return survivor_Name

func update_details(info: Dictionary):
    survivor_Name = info.get("name")
    carrying_capacity = info.get("carrying_capacity")
    base_movement_speed = info.get("movement_speed")
    backstory = info.get("backstory")

func add_condition(condition: Condition):
    conditions.append(condition)

func check_conditions():
    for x in conditions:
        var condition: String = x.condition_name
        match condition:
            "dehydrated":
                if x.stack_count == 3:
                    is_dead = true
            "malnutritioned":
                if x.stack_count == 7:
                    is_dead = true
            "leg_wound":
                movement_multiplier = 0.75 * x.stack_count
            "arm_wound":
                carry_multiplier = 0.75 * x.stack_count

# Update needs over time
func update_needs(delta: float):
    if is_dead:
        return

    thirst -= THIRST_DEPLETION_RATE * delta / 86400
    hunger -= HUNGER_DEPLETION_RATE * delta / 86400
    sleep -= SLEEP_DEPLETION_RATE * delta / 86400
    recreation -= RECREATION_DEPLETION_RATE * delta / 86400
    socialisation -= SOCIALISATION_DEPLETION_RATE * delta / 86400

    # Ensure needs do not drop below 0
    thirst = max(thirst, 0)
    hunger = max(hunger, 0)
    sleep = max(sleep, 0)
    recreation = max(recreation, 0)
    socialisation = max(socialisation, 0)

    # Check for death due to unmet needs
    if thirst == 0 or hunger == 0 or sleep == 0:
        is_dead = true

# Update resource consumption over time
func update_resource_consumption(delta: float):
    if is_dead:
        return

    water_stockpile -= water_consumption_rate * delta / 86400
    food_stockpile -= food_consumption_rate * delta / 86400

    # Ensure stockpiles do not drop below 0
    water_stockpile = max(water_stockpile, 0)
    food_stockpile = max(food_stockpile, 0)

# Evaluate and select the highest priority goal
func evaluate_goals():
    if goals.size() == 0:
        return

    # Sort goals by priority (higher priority first)
    goals.sort_custom(self, "_compare_goals")
    current_goal = goals[0]
    select_next_task()

# Compare function for sorting goals by priority
func _compare_goals(a, b):
    return b.priority - a.priority

# Select the next task from the current goal's task list
func select_next_task():
    if current_goal == null:
        return

    for task in current_goal.tasks:
        if not task_is_complete(task):
            current_task = task
            break

# Check if a task and its prerequisites are complete
func task_is_complete(task: Task):
    for prerequisite in task.prerequisites:
        if not task_is_complete(prerequisite):
            return false
    return task.action.call()

# Execute the current task
func execute_current_task():
    if current_task == null:
        return

    if task_is_complete(current_task):
        current_task = null
        select_next_task()