extends CharacterBody2D

var is_jumping = false

const SPEED = 160
const JUMP_STOP_SPEED = -60
const JUMP_VELOCITY = -320
const MAX_FALL_SPEED = 180


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	apply_gravity(delta)
	apply_inputs()
	move_and_slide()

func apply_inputs():
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene()

	if is_on_floor():
		is_jumping = false
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	if is_jumping and Input.is_action_just_released("jump"):
		velocity.y = max(velocity.y, JUMP_STOP_SPEED) 

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	
	if direction != 0:
		$AnimatedSprite2D.flip_h = direction != 1

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y = min(velocity.y + gravity * delta, MAX_FALL_SPEED)
	else:
		velocity.y = 0



