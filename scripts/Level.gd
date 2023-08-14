extends Node2D

signal end_reached

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player: CharacterBody2D = $TileMap/player/CharacterBody2D
	var end: StaticBody2D  = $TileMap/end/StaticBody2D
	
	for i in player.get_slide_collision_count():
		var collision = player.get_slide_collision(i)
		
		if collision.get_collider_rid() == end.get_rid():
			end_reached.emit()
