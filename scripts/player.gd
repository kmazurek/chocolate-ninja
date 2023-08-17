extends Node2D

var color: String = "light"
@export var hiding: bool = true

signal ate_chocolate(c: String)


@onready var body = $body
@onready var tile_map = get_parent()

func _ready():
	add_to_group("player")

func _process(_delta):
	check_if_hidden()
	check_if_eating()
	
func check_if_eating():
	var chocolate = get_tree().get_nodes_in_group("chocolate")
	for c in chocolate:
		if c.overlaps_body(body):
			eat_chocolate(c)
			
func eat_chocolate(c: Area2D):
	match c.get_parent().name:
		"chocolate_light": 
				color = "light"
		"chocolate_dark":
				color = "dark"
	ate_chocolate.emit(color)
	c.queue_free()


func check_if_hidden():
	# TODO - Why is this position shift needed? xD
	var player_pos = body.position + Vector2(8, 8) 
	print (player_pos)
	var tile_player_pos = tile_map.local_to_map(player_pos)
	print(tile_player_pos)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, tile_player_pos)
	print(tile_data)
	if tile_data:
		var data = tile_data.get_custom_data(Common.DataLayer_Shade)
		print(data)
		if data == "light" or data == "dark":
			hiding = data == color
		else:
			hiding = false
	else: 
		hiding = "dark" == color
		
