extends LinkButton

func _on_Start_pressed():
	var scene_path = "res://Scenes/Tutorial.tscn"
	get_tree().change_scene(scene_path)

func _on_high_score_pressed():
	get_tree().change_scene("res://Scenes/HighScore.tscn")
