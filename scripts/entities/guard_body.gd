extends CharacterBody2D

signal direction_changed(direction: int)

const SPEED = 50.0
const RANGE = 5

var on_route = false
@onready var sight = $sight


func _ready():
	add_to_group("guards")
	velocity.x = -SPEED


func _physics_process(_delta):
	var is_on_route = is_overlapping_route()

	if on_route and !is_on_route:
		on_route = false
		velocity.x = -velocity.x
		scale.x = scale.x * -1
	elif !on_route and is_on_route:
		on_route = true

	move_and_slide()


func is_in_view(body: CharacterBody2D) -> bool:
	return sight.overlaps_body(body)


func is_overlapping_route():
	var routes = get_tree().get_nodes_in_group("guard_routes")
	for r in routes:
		if r.overlaps_body(self):
			return true
	return false
