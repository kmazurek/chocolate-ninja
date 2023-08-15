extends CharacterBody2D

const SPEED = 160
const JUMP_VELOCITY = 320

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	apply_gravity(delta)
	apply_inputs()
	move_and_slide()


func apply_inputs():
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene()

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * SPEED
		animation.flip_h = direction == -1
	else:
		velocity.x = 0


func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
