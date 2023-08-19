extends Node2D


signal end_entered
signal door_opened

var opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("end")

func open():
	opened = true
	door_opened.emit()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if opened and body.has_method("is_player") and body.is_player(): 
		body.activate_smokebomb()
		end_entered.emit()
