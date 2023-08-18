extends CharacterBody2D

signal direction_changed(direction: int)

const SPEED = 50.0
const RANGE = 5
const WAIT_UNTIL_TURN = 2

var wait: float = 0

@onready var sight = $sight


var current_state: Common.GuardState
signal guard_state_updated(old_state: Common.GuardState, new_state: Common.GuardState)

func _ready():
	add_to_group("guards")
	velocity.x = -SPEED


func _physics_process(delta):
	var is_on_route = is_overlapping_route()

	match current_state:
		Common.GuardState.IDLE: 
			wait += delta
			if wait > WAIT_UNTIL_TURN:
				change_state(Common.GuardState.RETURNING)
				scale.x = scale.x * -1
				velocity.x = -velocity.x
		Common.GuardState.RETURNING:
			if is_on_route:
				change_state(Common.GuardState.WALKING)
		Common.GuardState.WALKING:
			if !is_on_route:
				change_state(Common.GuardState.IDLE)
				wait = 0

	if current_state != Common.GuardState.IDLE:
		move_and_slide()


func is_in_view(body: CharacterBody2D) -> bool:
	return sight.overlaps_body(body)


func is_overlapping_route():
	var routes = get_tree().get_nodes_in_group("guard_routes")
	for r in routes:
		if r.overlaps_body(self):
			return true
	return false

func change_state(new_state: Common.GuardState):
	if new_state != current_state:
		guard_state_updated.emit(current_state, new_state)
		current_state = new_state
