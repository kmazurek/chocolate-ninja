extends Node2D

signal end_reached

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
var end: Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end == null:
		end = $TileMap/end/Area2D
		end.connect("body_entered", _on_end_entered)

func _on_end_entered(body: CharacterBody2D): 
	if body.get_parent().name == "player":
		end_reached.emit()
	
