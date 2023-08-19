extends AudioStreamPlayer

@onready var chomp_stream = load("res://assets/audio/sfx/ninja/ninja-chomp.tres")
@onready var busted_stream = load("res://assets/audio/sfx/ninja/ninja-busted.tres")
@onready var poof_stream = load("res://assets/audio/sfx/ninja/ninja-poof.tres")

func _ready():
	var player = get_parent()
	var body = player.get_node("body")
	player.connect("ate_chocolate", _on_player_ate_chocolate)
	player.connect("got_seen", _on_player_got_seen)
	body.connect("player_state_updated", _on_body_player_state_updated)

func _on_player_ate_chocolate(c: String):
	stream = chomp_stream
	play()

func _on_player_got_seen(_position):
	stream = busted_stream
	play()

func _on_body_player_state_updated(old_state: Common.PlayerState, new_state: Common.PlayerState):
	match new_state:
		Common.PlayerState.LEAVING:
			stream = poof_stream
			play()
