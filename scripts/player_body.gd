extends CharacterBody2D

const SPEED = 160
const JUMP_VELOCITY = 320

signal direction_changed(direction: int)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	apply_gravity(delta)
	apply_inputs()
	
	if velocity.x != 0:
		animation.flip_h = velocity.x < 0
		
	move_and_slide()


func apply_inputs():
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene()

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	var velocity_x = direction * SPEED
	var is_direction_different  = sign(velocity_x) != sign(velocity.x)

	velocity.x = velocity_x
	if (is_direction_different and direction != 0):
		direction_changed.emit(direction)

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
