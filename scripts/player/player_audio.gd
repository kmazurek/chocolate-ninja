extends AudioStreamPlayer

@onready var chomp_stream = load("res://assets/audio/sfx/ninja/ninja-chomp.tres")
@onready var busted_stream = load("res://assets/audio/sfx/ninja/ninja-busted.tres")

func _ready():
	var player = get_parent()
	player.connect("ate_chocolate", _on_player_ate_chocolate)
	player.connect("got_seen", _on_player_got_seen)

func _on_player_ate_chocolate(c: String):
	stream = chomp_stream
	play()

func _on_player_got_seen(_position):
	stream = busted_stream
	play()
