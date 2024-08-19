extends Control
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
var lives : Array[Node] = []
@onready var h_box_container = $MarginContainer/VBoxContainer/HBoxContainer
var max_lives = 3
func _ready():
	ScoreManager.on_score_changed.connect(increase_score)
	load_lives(GameManager.lives)
	
func increase_score(score: int):
	score_label.text = str(score) + " points"

func load_lives(current_lives : int):
	lives = h_box_container.get_children()
	var lifes_to_decrease = max_lives - current_lives
	for x in lifes_to_decrease:
		decrease_life()

func decrease_life():
	var life : Node =  lives.pop_back()
	life.hide()
