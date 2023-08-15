extends Node2D


signal end_entered
signal door_opened

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("end")

func open():
	door_opened.emit()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.get_parent().name == "player":
		end_entered.emit()
