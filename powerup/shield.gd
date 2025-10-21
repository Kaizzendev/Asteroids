extends Node2D

@export var speed: float = 1.0    
var parent_rotation

func _ready():
	top_level = true
func _process(delta):
	position = get_parent().position
	rotation += (speed * delta) 
