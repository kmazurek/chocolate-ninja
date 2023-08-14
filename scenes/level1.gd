extends "res://scripts/Level.gd"

func _on_end_reached():
	get_tree().change_scene_to_file("res://scenes/level2.tscn")	
