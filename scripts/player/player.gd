extends Node2D

var color: String = Common.ChocolateColor_Light
@export var hiding: bool = true
@export var seen: bool = false

signal ate_chocolate(c: String)


@onready var body: CharacterBody2D = $body
@onready var tile_map: TileMap = get_parent()

func _ready():
	add_to_group("player")

func _process(_delta):
	check_if_hidden()
	check_if_eating()
	
	if hiding:
		seen = false
	else: 
		check_if_seen()
	
func check_if_eating():
	var chocolate = get_tree().get_nodes_in_group("chocolate")
	for c in chocolate:
		if c.overlaps_body(body):
			eat_chocolate(c)
			
func check_if_seen():
	var guards = get_tree().get_nodes_in_group("guards")
	seen = false
	for g in guards:
		seen = seen || g.call("is_in_view", body)
			
func eat_chocolate(c: Area2D):
	ate_chocolate.emit(c.color)
	c.queue_free()


func check_if_hidden():
	var player_pos = body.global_position
	var tile_player_pos = tile_map.local_to_map(player_pos)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, tile_player_pos)
	if tile_data:
		var data = tile_data.get_custom_data(Common.DataLayer_Shade)
		if data == "light" or data == "dark":
			hiding = data == color
		else:
			hiding = false
	else: 
		hiding = "dark" == color
		
