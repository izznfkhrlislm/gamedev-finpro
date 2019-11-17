extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 400
const UP = Vector2(0,-1)
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	if Input.is_action_pressed('ui_right'):
		$Sprite.flip_h = false
		velocity.x += speed
	if Input.is_action_pressed('ui_left'):
		$Sprite.flip_h = true
		velocity.x -= speed
	if Input.is_action_pressed('ui_up'):
		velocity.y += speed
	if Input.is_action_pressed('ui_down'):
		velocity.y -= speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#pass
