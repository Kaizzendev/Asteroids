extends Node
var paused : bool
var lives : int = 3

func _ready():
	ScoreManager.give_score_amount(ScoreManager.total_score)
