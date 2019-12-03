extends KinematicBody2D

func _on_Rabbit_entered(body):
	if body.name == "Player":
		global.score += 100
		queue_free()
