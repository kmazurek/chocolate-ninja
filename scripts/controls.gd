extends MenuButton

func _pressed():
	get_tree().get_root().get_node("menu").call("load_game")
