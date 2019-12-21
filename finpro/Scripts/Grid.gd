extends TileMap

enum { EMPTY = -1, WALL, LAVA, PATH }


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		PATH:
			$Player.againts_wall = false
			return update_pawn_position(pawn, cell_start, cell_target)
		WALL:
			if !$Player.invincible:
				if get_cellv(cell_start) == WALL:
					get_tree().change_scene("res://Scenes/GameOver.tscn")
				$Player.againts_wall = true
			else:
				return update_pawn_position(pawn, cell_start, cell_target)
		EMPTY, LAVA:
			if !$Player.invincible:
				get_tree().change_scene("res://Scenes/GameOver.tscn")
			else:
				return update_pawn_position(pawn, cell_start, cell_target)

func update_pawn_position(pawn, cell_start, cell_target):
	return map_to_world(cell_target) + cell_size / 2
