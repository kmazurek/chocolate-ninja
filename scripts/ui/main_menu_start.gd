extends MenuButton


func _pressed():
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
