extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/LinkButton.grab_focus()
	
func _physics_process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/LinkButton.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/LinkButton.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/LinkButton2.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/LinkButton2.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$MarginContainer/CenterContainer/VBoxContainer/LinkButton.grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_LinkButton_pressed():
	$MarginContainer/CenterContainer/VBoxContainer/LinkButton.grab_focus()
	get_tree().paused = not get_tree().paused
	visible = not visible

func _on_LinkButton2_pressed():
	get_tree().change_scene(str("res://Scenes/Menu.tscn"))
