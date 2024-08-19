extends Control
@onready var score = $MarginContainer/VBoxContainer/Score


func _ready():
	score.text = "Score: " + str(ScoreManager.total_score)

func _on_restart_pressed():
	ScoreManager.give_score_amount(0)
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_menu_pressed():
	ScoreManager.give_score_amount(0)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
