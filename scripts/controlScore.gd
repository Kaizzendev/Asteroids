extends Control
@onready var score_label = $MarginContainer/ScoreLabel
func _ready():
	ScoreManager.on_score_changed.connect(increase_score)

func increase_score(score: int):
	score_label.text = str(score) + " points"
