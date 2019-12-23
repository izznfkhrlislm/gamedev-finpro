extends LinkButton

func _on_Continue_pressed():
	randomize()
	var scene_path = "res://Scenes/World" + str(randi() % 6 + 1) + ".tscn"
	get_tree().change_scene(scene_path)