extends LinkButton

func _on_Start_pressed():
	var scene_path = "res://Scenes/World" + str(randi() % 4 + 1) + ".tscn"
	print(scene_path)
	get_tree().change_scene(scene_path)
