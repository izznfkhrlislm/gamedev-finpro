extends KinematicBody2D

func _on_Rabbit_entered(body):
	if body.name == "Player":
		$Acquired.play()
		global.score += 10
		queue_free()
