extends Node2D

class_name Powerup

@export var duration: int
	
func use_powerup(player: Player):
	visible = false
	set_physics_process(false)
	pass

func _on_area_2d_area_entered(area: Area2D):
	if area.name == "Player" :
		use_powerup(area.get_parent())
