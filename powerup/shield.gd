extends Node2D

@export var speed: float = 1.0    
var parent_rotation
@onready var orbit = $Orbit

var despawn_duration = 10
@export var flash_duration: float = 1.0
@export var flash_interval: float = 0.1

var balls 

func _ready():
	balls = orbit.get_children()
	top_level = true
	await get_tree().create_timer(despawn_duration - flash_duration).timeout
	await flash()
	
func _process(delta):
	position = get_parent().position
	rotation += (speed * delta) 

func flash():
	var end_time = Time.get_ticks_msec() / 1000.0 + flash_duration
	while Time.get_ticks_msec() / 1000.0 < end_time:
		for ball in balls:
			ball.visible = false
		await get_tree().create_timer(flash_interval).timeout
		for ball in balls:
			ball.visible = true
		await get_tree().create_timer(flash_interval).timeout
