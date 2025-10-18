extends Control
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
var lives : Array[Node] = []
@onready var h_box_container = $MarginContainer/VBoxContainer/HBoxContainer
const LIFE_ICON = preload("res://scenes/life_icon.tscn")
func _ready():
	ScoreManager.on_score_changed.connect(increase_score)
	ScoreManager.on_life_changed.connect(increase_life)
	load_lives(GameManager.lives)
func increase_score(score: int):
	score_label.text = str(score) + " points"

func load_lives(current_lives : int):
	for x in current_lives:
		var life = LIFE_ICON.instantiate() as TextureRect
		h_box_container.add_child(life)
		lives.append(life)

func increase_life():
	GameManager.lives += 1
	var life = LIFE_ICON.instantiate() as TextureRect
	h_box_container.add_child(life)
	lives.append(life)
	

func decrease_life():
	var life : Node =  lives.pop_back()
	life.hide()
