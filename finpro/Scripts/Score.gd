extends Label

func _ready():
	global.score = global.score if global.score % 2 == 0 else global.score-1
	self.text = "Score:\n" + str(global.score)