extends Node2D

@onready var light_sprite: AnimatedSprite2D = $AnimatedSpriteLight
@onready var light_anim_player: AnimationPlayer = $AnimatedSpriteLight/AnimationPlayer
@onready var dark_sprite: AnimatedSprite2D = $AnimatedSpriteDark
@onready var dark_anim_player: AnimationPlayer = $AnimatedSpriteDark/AnimationPlayer

@onready var active_anim_player: AnimationPlayer

func _ready():
	var player = get_parent().get_parent()
	player.connect("ate_chocolate", _on_player_ate_chocolate)
	var player_body = get_parent()
	player_body.connect("player_state_updated", _on_player_state_updated)
	_switch_color(Common.ChocolateColor_Light)

func _on_player_ate_chocolate(chocolate_color: String):
	_switch_color(chocolate_color)
	
func _on_player_state_updated(old_state: Common.PlayerState, new_state: Common.PlayerState):
	var animation_name: String = "idle"
	match new_state:
		Common.PlayerState.IDLE:
			if old_state == Common.PlayerState.FALLING:
				animation_name = "jump_end"
			else:
				animation_name = "idle"
		Common.PlayerState.RUNNING:
			animation_name = "run"
		Common.PlayerState.JUMPING:
			animation_name = "jump_fly"
	active_anim_player.play(animation_name)

func _switch_color(color: String):
	match color:
		Common.ChocolateColor_Light:
				active_anim_player = light_anim_player
				light_sprite.visible = true
				dark_sprite.visible = false
		Common.ChocolateColor_Dark:
				active_anim_player = dark_anim_player
				light_sprite.visible = false
				dark_sprite.visible = true
