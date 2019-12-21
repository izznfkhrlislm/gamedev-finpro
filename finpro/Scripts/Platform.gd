extends KinematicBody2D

export (int) var speed = -100

var velocity = Vector2()

func _process(delta):
	if position.x < -get_viewport().size.x or position.x > get_viewport().size.x:
		queue_free() 

func _physics_process(delta):
	velocity.x = speed
	velocity = move_and_slide(velocity)
