extends CharacterBody2D

signal direction_changed(direction: int)

const SPEED = 50.0
const RANGE = 5
const WAIT_UNTIL_TURN = 2

var state = "patrolling"
var wait: float = 0

@onready var sight = $sight


func _ready():
	add_to_group("guards")
	velocity.x = -SPEED


func _physics_process(delta):
	var is_on_route = is_overlapping_route()

	match state:
		"waiting": 
			wait += delta
			if wait > WAIT_UNTIL_TURN:
				state = "returning"
				scale.x = scale.x * -1
				velocity.x = -velocity.x
		"returning":
			if is_on_route:
				state = "patrolling"
		"patrolling":
			if !is_on_route:
				state = "waiting"
				wait = 0

	if state != "waiting":
		move_and_slide()


func is_in_view(body: CharacterBody2D) -> bool:
	return sight.overlaps_body(body)


func is_overlapping_route():
	var routes = get_tree().get_nodes_in_group("guard_routes")
	for r in routes:
		if r.overlaps_body(self):
			return true
	return false
