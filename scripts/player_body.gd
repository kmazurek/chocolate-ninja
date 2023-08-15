extends CharacterBody2D

const SPEED = 160
const JUMP_VELOCITY = 320

signal direction_changed(direction: int)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var tileMap: TileMap

func _ready():
	tileMap = get_parent().get_parent()

func _process(_delta):
	check_light_shade()

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

func check_light_shade():
	# TODO - Why is this position shift needed? xD
	var player_pos = position + Vector2(8,0)
	var tile_player_pos = tileMap.local_to_map(player_pos)
	var tileData: TileData = tileMap.get_cell_tile_data(0, tile_player_pos)
	if tileData:
		var shade = tileData.get_custom_data(Common.DataLayer_Shade)
		print(shade)
