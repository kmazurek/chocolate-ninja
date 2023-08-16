extends Node2D

var color: String = "light"
signal ate_chocolate(c: String)

@onready var body = $body

func _process(delta):
	var chocolate = get_tree().get_nodes_in_group("chocolate")
	for c in chocolate:
		if c.overlaps_body(body):
			eat_chocolate(c)

			
func eat_chocolate(c: Area2D):
	match c.get_parent().name:
		"chocolate_light": 
				color = "light"
		"chocolate_dark":
				color = "dark"
	ate_chocolate.emit(color)
	c.queue_free()

