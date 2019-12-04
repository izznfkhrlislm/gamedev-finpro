extends MarginContainer

func _ready():
	$VBoxContainer/Label2.text = str(global.highscore[0])
	$VBoxContainer/Label3.text = str(global.highscore[1])
	$VBoxContainer/Label4.text = str(global.highscore[2])
	$VBoxContainer/Label5.text = str(global.highscore[3])
	$VBoxContainer/Label6.text = str(global.highscore[4])


func _on_main_menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
