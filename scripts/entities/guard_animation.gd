extends AnimatedSprite2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	var body = get_parent()
	body.connect("guard_state_updated", _on_guard_state_updated)
	anim_player.play("idle")
	
func _on_guard_state_updated(old_state: Common.GuardState, new_state: Common.GuardState):
	var animation_name: String = "idle"
	match new_state:
		Common.GuardState.IDLE:
			animation_name = "idle"
		Common.GuardState.WALKING:
			animation_name = "walk"
	anim_player.play(animation_name)
