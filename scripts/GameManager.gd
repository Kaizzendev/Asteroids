extends Node
var paused : bool
var lives : int = 3

func _ready():
	ScoreManager.give_score_amount(ScoreManager.total_score)
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause()
		
func pause():
	if paused:
		Engine.time_scale = 1
	else:
		Engine.time_scale = 0
		
	paused = !paused
	
