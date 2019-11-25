extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 200

onready var direction = 'up'
onready var axis = 'y'

var velocity = Vector2()

func get_input():
	if Input.is_action_pressed('ui_right'):
		$Sprite.flip_h = false
		direction = 'right'
		axis = 'x'
	if Input.is_action_pressed('ui_left'):
		$Sprite.flip_h = true
		direction = 'left'
		axis = 'x'
	if Input.is_action_pressed('ui_up'):
		direction = 'up'
		axis = 'y'
	if Input.is_action_pressed('ui_down'):
		direction = 'down'
		axis = 'y'
	if Input.is_action_pressed('jump'):
		if axis == 'y':
			if direction == 'up':
				velocity.y -= speed
			else:
				velocity.y += speed
		else:
			if direction == 'right':
				velocity.x += speed
			else:
				velocity.x -= speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# pass
