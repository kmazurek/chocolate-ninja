extends AnimatedSprite2D

func _on_character_body_2d_direction_changed(direction):
	flip_h = direction == -1
