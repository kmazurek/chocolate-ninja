extends AnimatedSprite2D


func _ready():
	play("frame_1_loop")
	await get_tree().create_timer(6.0).timeout
	play("frame_2_loop")
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
