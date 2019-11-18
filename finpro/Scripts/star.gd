extends Sprite
export var velocity = Vector2()
func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(velocity*delta)
	if position.y >= get_viewport_rect().size.y:
		position = Vector2(0, -1080)
	pass
