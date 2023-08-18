extends CharacterBody2D

const SPEED = 130
const JUMP_STOP_SPEED = -60
const JUMP_VELOCITY = -260
const MAX_FALL_SPEED = 180
const JUMP_DOWN_VELOCITY = -80

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_falling_through = false

@onready var tile_map: TileMap = get_parent().get_parent()

var current_state: Common.PlayerState
signal player_state_updated(old_state: Common.PlayerState, new_state: Common.PlayerState)

func _physics_process(delta):
	apply_gravity(delta)
	apply_inputs()
	move_and_slide()

func apply_inputs():
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene()

	var is_fallthrough = not get_collision_layer_value(3)

	if is_on_floor():
		is_jumping = false
		set_fallthrough(true)
		
	if is_on_floor() and Input.is_action_pressed("move_down") and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_DOWN_VELOCITY
		is_jumping = true
		set_fallthrough(false)
	elif is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	if is_on_fallthrough() and is_fallthrough:
		is_falling_through = true
	elif not is_on_fallthrough() and is_falling_through:
		set_fallthrough(true)
		is_falling_through = false
		
		
		

		
	if is_jumping and Input.is_action_just_released("jump"):
		velocity.y = max(velocity.y, JUMP_STOP_SPEED)

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	
	if direction != 0:
		$Animations/AnimatedSpriteLight.flip_h = direction != 1
		$Animations/AnimatedSpriteDark.flip_h = direction != 1
		
	if is_on_floor():
		if velocity.x != 0:
			try_change_state(Common.PlayerState.RUNNING)
		else:
			try_change_state(Common.PlayerState.IDLE)
	else:
		if velocity.y > 0:
			try_change_state(Common.PlayerState.JUMPING)
		else:
			try_change_state(Common.PlayerState.FALLING)

func is_on_fallthrough():
	var coordinates = tile_map.local_to_map(global_position)
	
	var data = tile_map.get_cell_tile_data(0, coordinates)
	if data == null: return false
	
	var custom_data = data.get_custom_data_by_layer_id(0)
	return custom_data == "fallthrough"
		
	
	
func set_fallthrough(b: bool): 
	set_collision_layer_value(3, b)
	set_collision_mask_value(3, b)

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y = min(velocity.y + gravity * delta, MAX_FALL_SPEED)
	else:
		velocity.y = 0


func try_change_state(new_state: Common.PlayerState):
	if new_state != current_state:
		player_state_updated.emit(current_state, new_state)
		current_state = new_state
