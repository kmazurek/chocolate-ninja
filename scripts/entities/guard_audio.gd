extends AudioStreamPlayer

@onready var alert_stream = load("res://assets/audio/sfx/guard/guard-alert.tres")

func _ready():
	var body = get_parent()
	body.connect("guard_state_updated", _on_guard_state_updated)

func _on_guard_state_updated(old_state: Common.GuardState, new_state: Common.GuardState):
	match new_state:
		Common.GuardState.ALARMED:
			stream = alert_stream
			play()
