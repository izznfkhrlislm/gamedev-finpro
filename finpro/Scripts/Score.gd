extends Label

func _ready():
	self.text = "Score:\n" + str(global.score) + ' ' + str(global.counter)