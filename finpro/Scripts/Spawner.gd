extends Node2D

enum TYPES {Platform, Enemy}

export (TYPES) var type = TYPES.Enemy
export (int) var speed = -100
export (float) var spawn_rate = 0.3

var spawn

var current_time = 0


func _ready():
	current_time = spawn_rate
	if type:
		spawn = preload("res://Scenes/Enemy.tscn")
	else:
		spawn = preload("res://Scenes/Platform.tscn")


func _process(delta):
	current_time -= delta
	if current_time <= 0:
		current_time = spawn_rate
		
		var new_spawn = spawn.instance()
		new_spawn.speed = speed
		add_child(new_spawn)