extends 'object.gd'

onready var Grid = get_parent()
onready var width = get_viewport().size.x
onready var height = get_viewport().size.y

var againts_wall = false
var direction = 'up'
var rabbit = preload("res://Scenes/Rabbit.tscn")

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
	
	if !againts_wall and direction == 'up':
		global.counter += 1
	if !againts_wall and direction == 'down':
		global.counter -= 1
		
	if global.counter == 5:
		global.counter = 0
		create_rabbit_instance()
	if global.counter < 0:
		global.counter = 0
	
	match direction:
		'up':
			$Sprite.play('JumpUP')
		'down':
			$Sprite.play('JumpDOWN')
		'left':
			$Sprite.flip_h = true
			$Sprite.play('JumpH')
		'right': 
			$Sprite.flip_h = false
			$Sprite.play('JumpH')
		
	$Sprite.frame = 0
	$Jump.play()

	var move_direction = (target_position - position).normalized()
	position = target_position

	# Stop the function execution until the animation finished
	yield($Sprite, "animation_finished")
	
	set_process(true)

func create_rabbit_instance():
	randomize()
	var rabbit_instance = rabbit.instance()
	var pos = Vector2(rand_range(0, width), rand_range(0, height))
	var cell = Grid.get_cellv(Grid.world_to_map(pos))
	var is_path = cell == CELL_TYPES.PATH
	
	while !is_path:
		pos = Vector2(rand_range(0, width), rand_range(0, height))
		is_path = Grid.get_cellv(Grid.world_to_map(pos)) == CELL_TYPES.PATH
	
	if Grid != null:
		pos = Grid.map_to_world(Grid.world_to_map(pos)) + Grid.cell_size / 2
		rabbit_instance.set_position(pos)
		Grid.add_child(rabbit_instance)
