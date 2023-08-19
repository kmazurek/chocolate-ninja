extends Node2D

@export var next_level: String

var end: Node2D
var done: bool = false

var levels: Array = [
	preload("res://scenes/levels/d_level0_tutorial_eat_chocolate.tscn"),
	preload("res://scenes/levels/d_level1_tutorial_jumps.tscn"),
	preload("res://scenes/levels/d_level2_tutorial_guard.tscn"),
	preload("res://scenes/levels/d_level3_tutorial_guard_hit.tscn"),
	preload("res://scenes/levels/d_level4.tscn"),
	preload("res://scenes/levels/d_level5.tscn"),
	preload("res://scenes/levels/d_level6_bridges.tscn"),
	preload("res://scenes/levels/d_level7_B&W.tscn"),
	preload("res://scenes/levels/d_level8_floor_is_lava.tscn"),
	preload("res://scenes/levels/d_level9_drop.tscn"),
	preload("res://scenes/levels/d_level10_final.tscn")
]

var ending: PackedScene = preload("res://scenes/ending.tscn")

var current_level_index = -1
var current_level: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_advance_level()


func _advance_level():
	current_level_index = current_level_index + 1
	var next = levels[current_level_index].instantiate()

	if current_level != null:
		current_level.queue_free()
		remove_child(current_level)
	current_level = next
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
	await get_tree().create_timer(0.7).timeout
	if done:
		if current_level_index == len(levels) - 1:
			remove_child(current_level)
			add_child(ending.instantiate())
		else:
			_advance_level()


func _on_tile_map_child_added(node: Node):
	if node.name == "end":
		node.connect("end_entered", _on_end_entered)
		done = false

	if node.name == "player":
		node.connect("got_seen", _on_got_seen)
		node.connect("please_restart", restart_level)


func _on_got_seen(p: Vector2):
	var camera: Camera2D = get_tree().get_first_node_in_group("camera")
	camera.position = p
	camera.zoom = Vector2(2, 2)
	await get_tree().create_timer(0.33).timeout
	camera.zoom = Vector2(4, 4)
	await get_tree().create_timer(0.33).timeout
	camera.zoom = Vector2(8, 8)
	await get_tree().create_timer(1.0).timeout
	restart_level()


func restart_level():
	current_level.queue_free()
	var restarted = levels[current_level_index].instantiate()
	current_level = restarted
	add_child(current_level)
	var tileMap = current_level.get_node("TileMap")
	tileMap.connect("child_entered_tree", _on_tile_map_child_added)
