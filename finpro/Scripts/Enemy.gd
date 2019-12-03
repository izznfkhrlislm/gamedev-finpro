extends KinematicBody2D

export (int) var speed = -100
#export (int) var GRAVITY = 1200

#const UP = Vector2(0,-1)

var velocity = Vector2()

func _process(delta):
	if position.x < -get_viewport().size.x or position.x > get_viewport().size.x:
		queue_free() 

func _physics_process(delta):
#	velocity.y += delta * GRAVITY
	velocity.x = speed
	velocity = move_and_slide(velocity)
