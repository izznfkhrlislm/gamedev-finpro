extends Camera2D

export(NodePath) var player_path

onready var player = get_node(player_path)
onready var viewport = get_viewport().size

func _physics_process(delta):
	var player_y = player.position.y
	if player_y < position.y:
		position = Vector2(floor(viewport.x/2), player_y-floor(viewport.y/2))