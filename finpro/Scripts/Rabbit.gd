extends KinematicBody2D

func _on_Rabbit_entered(body):
	if body.name == "Player":
		queue_free()
