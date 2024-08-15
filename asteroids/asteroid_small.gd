extends Asteroid

func _ready():
	super()
	current_type = Type.Med
	score = 300

func destroy():
	AudioController.play_small_crash()
	super()
