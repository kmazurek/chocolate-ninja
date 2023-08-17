extends CanvasLayer

@onready var label_hiding = $hiding
@onready var label_seen = $seen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	if player.hiding:
		label_hiding.text = "hiding"
	else:
		label_hiding.text = "visible"
		
	if player.seen:
		label_seen.text = "seen"
	else:
		label_seen.text = "not seen"
