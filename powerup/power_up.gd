extends Node2D

class_name Powerup
@onready var sprite_2d = $Sprite2D

@export var duration: int
@export var despawn_duration: int = 10
@export var flash_duration: float = 2.0
@export var flash_interval: float = 0.1

var picked: bool = false

func use_powerup(player: Player):
	visible = false
	set_physics_process(false)

func _on_area_2d_area_entered(area: Area2D):
	if area.name == "Player" :
		picked = true
		use_powerup(area.get_parent())

func _ready():
	await get_tree().create_timer(despawn_duration - flash_duration).timeout
	await flash()
	if !picked:
		queue_free()
		
func flash():
	var end_time = Time.get_ticks_msec() / 1000.0 + flash_duration
	while Time.get_ticks_msec() / 1000.0 < end_time:
		sprite_2d.visible = false
		await get_tree().create_timer(flash_interval).timeout
		sprite_2d.visible = true
		await get_tree().create_timer(flash_interval).timeout
