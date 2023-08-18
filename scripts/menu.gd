extends Node2D

var main_menu = load("res://scenes/main_menu.tscn")
var controls = load("res://scenes/controls.tscn")
var game = load("res://scenes/game_scene.tscn")

var current_scene: Node

func _ready():
	current_scene = main_menu.instantiate()
	add_child(current_scene)

func load_controls():
	remove_child(current_scene)
	current_scene = controls.instantiate()
	add_child(current_scene)

func load_game():
	get_tree().change_scene_to_packed(game)
