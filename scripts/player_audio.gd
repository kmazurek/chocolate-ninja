extends AudioStreamPlayer

@onready var chomp_stream = load("res://assets/audio/sfx/ninja/ninja-chomp.tres")

func _on_player_ate_chocolate(c: String):
	stream = chomp_stream
	play()
