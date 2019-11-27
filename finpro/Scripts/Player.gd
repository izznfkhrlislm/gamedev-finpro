extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 1500

onready var world = get_tree().current_scene
onready var width = get_viewport().size.x

var direction = 'up'
var axis = 'y'
var counter = 0
var rabbit = preload("res://Scenes/Rabbit.tscn")
var velocity = Vector2()

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed('ui_right'):
			$Sprite.flip_h = false
			direction = 'right'
			axis = 'x'
		if event.is_action_pressed('ui_left'):
			$Sprite.flip_h = true
			direction = 'left'
			axis = 'x'
		if event.is_action_pressed('ui_up'):
			direction = 'up'
			axis = 'y'
		if event.is_action_pressed('ui_down'):
			direction = 'down'
			axis = 'y'
		if event.is_action_pressed('jump'):
			if axis == 'y':
				if direction == 'up':
					velocity.y -= speed
					counter += 1
				else:
					velocity.y += speed
			else:
				if direction == 'right':
					velocity.x += speed
				else:
					velocity.x -= speed
			check_jump_count()
		
func check_jump_count():
	randomize()
	print(counter)
	print($Camera2D.get_camera_position())
	if counter == 20:
		var height = $Camera2D.get_camera_position().y
		var rabbit_instance = rabbit.instance()
		rabbit_instance.set_position(Vector2(rand_range(0, width), height-300))
		if world != null:
			world.add_child(rabbit_instance)
		counter = 0

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# pass
