extends KinematicBody2D

onready var Grid = get_parent()
onready var width = get_viewport().size.x
onready var height = get_viewport().size.y

var againts_wall = false
var direction = 'up'
var invincible = false
var on_platform = false
var platform_vel = Vector2.ZERO
var rabbit = preload("res://Scenes/Rabbit.tscn")
var star = preload("res://Scenes/Star.tscn")
var timer

func _ready():
	update_look_direction(Vector2(0, -1))

func _process(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		return
	update_look_direction(input_direction)
	
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
		
func _physics_process(delta):
	if on_platform:
		move_and_collide(platform_vel*delta)

func get_input_direction():
	var dir = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	match dir:
		Vector2(1, 1), Vector2(-1, 1), Vector2(1, -1), Vector2(-1, -1):
			dir = Vector2.ZERO
	return dir

func update_look_direction(dir):
	match dir:
		Vector2(-1, 0):
			direction = 'left' 
		Vector2(1, 0):
			direction = 'right' 
		Vector2(0, -1):
			direction = 'up'
		Vector2(0, 1):
			direction = 'down'
	
	$Sprite.frame = 0

func move_to(target_position):
	set_process(false)
	
	check_player_state()
	
	match direction:
		'up':
			$Sprite.play('JumpUP') if invincible == false else $Sprite.play('JumpUPP')
		'down':
			$Sprite.play('JumpDOWN') if invincible == false else $Sprite.play('JumpDOWNP')
		'left':
			$Sprite.flip_h = true
			$Sprite.play('JumpH') if invincible == false else $Sprite.play('JumpHP')
		'right': 
			$Sprite.flip_h = false
			$Sprite.play('JumpH') if invincible == false else $Sprite.play('JumpHP')
		
	$Sprite.frame = 0
	$Jump.play()

	var move_direction = (target_position - position).normalized()
	position = target_position

	# Stop the function execution until the animation finished
	yield($Sprite, "animation_finished")
	
	set_process(true)
	
func check_player_state():
	if !againts_wall and direction == 'up':
		global.counter += 1
	if !againts_wall and direction == 'down':
		global.counter -= 1
		
	if global.counter > 5:
		global.counter = 0
		create_instance(rabbit)
	if global.counter < 0:
		global.counter = 0
		
	if global.score != 0 and global.score % 50 == 0:
		create_instance(star)
		global.score += 1
		
func create_instance(scene):
	randomize()
	var scene_instance = scene.instance()
	var pos = Vector2(rand_range(0, width), rand_range(0, height))
	var cell = Grid.get_cellv(Grid.world_to_map(pos))
	var is_path = cell == 2 #2 = PATH TYPE
	
	while !is_path:
		pos = Vector2(rand_range(0, width), rand_range(0, height))
		cell = Grid.get_cellv(Grid.world_to_map(pos))
		is_path = cell == 2
	
	if Grid != null:
		pos = Grid.map_to_world(Grid.world_to_map(pos)) + Grid.cell_size / 2
		scene_instance.set_position(pos)
		Grid.add_child(scene_instance)

func _on_body_entered(body):
	if body.is_in_group('Stars'):
		body.queue_free()
		invincible = true
		$Sprite.animation = $Sprite.animation + 'P'
		$Sprite.play()
		$Sprite.frame = 0
		
		timer = Timer.new()
		timer.connect("timeout", self, "on_invincible_timeout")
		Grid.add_child(timer)
		timer.set_wait_time(5)
		timer.start()
		
	if body.is_in_group('Rabbits'):
		body.queue_free()
		if global.score != 0 and global.score % 50 == 1:
			global.score -= 1
		global.score += 10
	
func on_invincible_timeout():
	invincible = false
	timer.queue_free()
	$Sprite.animation = $Sprite.animation.left(len($Sprite.animation)-1)
	$Sprite.play()
	$Sprite.frame = 0
	Grid.request_move(self, Vector2.ZERO)
