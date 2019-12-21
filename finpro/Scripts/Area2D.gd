extends Area2D

export (String) var sceneName = "GameOver"

func _on_Area_Trigger_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene(str("res://Scenes/" + sceneName + ".tscn"))

func _on_body_entered_as_platform(body):
	if body.get_name() == "Player":
		body.on_platform = true
		body.platform_vel = get_parent().velocity

func _on_body_exited_as_platform(body):
	if body.get_name() == "Player":
		body.on_platform = false

func _on_body_entered_as_death_area(body):
	if body.get_name() == "Player":
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		body.on_death_area = true

func _on_body_exited_as_death_area(body):
	if body.get_name() == "Player":
		body.on_death_area = false

func _on_finish(body):
	if body.get_name() == "Player":
		randomize()
		var scene_path = "res://Scenes/World" + str(randi() % 5 + 1) + ".tscn"
		get_tree().change_scene(scene_path)