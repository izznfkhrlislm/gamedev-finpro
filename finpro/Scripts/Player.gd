extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 1500
export (NodePath) var camera_path

onready var world = get_tree().current_scene
onready var width = get_viewport().size.x
onready var height = get_viewport().size.y
onready var camera = get_node(camera_path)

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
	if counter == 20:
		create_rabbit_instance()
		counter = 0


func create_rabbit_instance():
	var rabbit_instance = rabbit.instance()
	rabbit_instance.set_position(Vector2(rand_range(0, width), camera.position.y-300))
	if world != null:
		world.add_child(rabbit_instance)


func _physics_process(delta):
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO


func exit_screen():
	if position.y > camera.position.y + height/2:
		pass #player dead
		
	if position.x > camera.position.x and axis == 'x':
		position = Vector2(32, position.y)
	elif position.x < camera.position.x and axis == 'x':
		position = Vector2(width-32, position.y)
