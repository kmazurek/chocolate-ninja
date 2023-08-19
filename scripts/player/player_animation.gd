extends Node2D

@onready var light_sprite: AnimatedSprite2D = $AnimatedSpriteLight
@onready var light_anim_player: AnimationPlayer = $AnimatedSpriteLight/AnimationPlayer
@onready var dark_sprite: AnimatedSprite2D = $AnimatedSpriteDark
@onready var dark_anim_player: AnimationPlayer = $AnimatedSpriteDark/AnimationPlayer

@onready var active_anim_player: AnimationPlayer

func _ready():
	switch_color(Common.ChocolateColor_Light)

func switch_color(color: String):
	match color:
		Common.ChocolateColor_Light:
				active_anim_player = light_anim_player
				light_sprite.visible = true
				dark_sprite.visible = false
		Common.ChocolateColor_Dark:
				active_anim_player = dark_anim_player
				light_sprite.visible = false
				dark_sprite.visible = true
				
func _on_player_ate_chocolate(chocolate_color: String):
	switch_color(chocolate_color)

func _on_body_player_state_updated(old_state: Common.PlayerState, new_state: Common.PlayerState):
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
		Common.PlayerState.LEAVING:
			active_anim_player.play("end_level", -1, 2)
			return
	active_anim_player.play(animation_name)


func _on_player_got_seen(_position):
	active_anim_player.play("busted_loop")
