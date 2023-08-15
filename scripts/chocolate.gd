extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	add_to_group("chocolate")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_parent().name == "player":
		remove_from_group("chocolate")
		queue_free()
		
