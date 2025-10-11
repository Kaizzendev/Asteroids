extends Node2D
class_name Ufo
var score: int = 1000
var speed : int = 100
const EXPLOSION = preload("res://scenes/explosion.tscn")
func _ready():
	pass

func _process(delta):
	move_local_x(delta * speed)

func death(byPlayer : bool):
	if byPlayer:
		ScoreManager.give_score_amount(score)
		AudioController.play_die_ufo()
	var explosion = EXPLOSION.instantiate() as Node2D
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
	

	
