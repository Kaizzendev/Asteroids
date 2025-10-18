extends Node2D

signal on_score_changed
signal on_life_changed

static var total_score : int 
func give_score_amount(score_amount: int):
	total_score += score_amount
	on_score_changed.emit(total_score)

func give_extra_life():
	on_life_changed.emit()
