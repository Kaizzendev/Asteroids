extends Node2D

class_name Ufo
var score: int = 1000
var speed : int = 100
func _ready():
	pass

func _process(delta):
	move_local_x(delta * speed)

func death(byPlayer : bool):
	if byPlayer:
		ScoreManager.give_score_amount(score)
	queue_free()
	
