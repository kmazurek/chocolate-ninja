extends AnimatedSprite2D

func _on_character_body_2d_direction_changed(direction):
	flip_h = direction == -1


func _on_player_ate_chocolate(c: String):
	play(c)
