extends Node2D


	
@export var next_level: String

var end: Node2D
var done: bool = false

var levels: Array = [
	preload("res://scenes/levels/d_level0_tutorial_eat_chocolate.tscn"),
	preload("res://scenes/levels/d_level1_tutorial_jumps.tscn")
]

var current_level_index = -1
var current_level: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	_advance_level()
	
func _advance_level():
	current_level_index = current_level_index + 1
	var next_level = levels[current_level_index].instantiate()
	
	if current_level != null:
		remove_child(current_level)
	current_level = next_level
	add_child(current_level)
	
	var tileMap = current_level.get_node("TileMap")
	tileMap.connect("child_entered_tree", _on_tile_map_child_added)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var chocolate = get_tree().get_nodes_in_group("chocolate")
	if chocolate.size() == 0 and not done:
		done = true
		get_tree().call_group("end", "open")
	
func _on_end_entered():
	print("_on_end_entered")
	if done:
		if current_level_index == len(levels) - 1:
			print("all levels finished")
		else:
			_advance_level()
	
func _on_tile_map_child_added(node: Node):
	if node.name == "end":
		node.connect("end_entered", _on_end_entered)
		done = false
	
