extends AnimationPlayer

func _ready():
	var door = get_parent()
	door.connect("door_opened", _on_door_opened)

func _on_door_opened():
	play("opening")
