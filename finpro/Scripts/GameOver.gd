extends Node2D

func _ready():
	global.highscore.append(global.score)
	global.highscore.sort_custom(self, "desc_order")
	if len(global.highscore) > 5:
		global.highscore.pop_back()
	
func desc_order(a, b):
	return a>b;