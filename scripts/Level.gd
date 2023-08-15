extends Node2D


	
@export var next_level: String

var end: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end == null:
		end = $TileMap/end
		end.connect("end_entered", _on_end_entered)
	
	var chocolate = get_tree().get_nodes_in_group("chocolate")
	print(next_level)
	if chocolate.size() == 0:
		get_tree().call_group("end", "open")
	

func _on_end_entered(): 
	get_tree().change_scene_to_file(next_level)	
	
