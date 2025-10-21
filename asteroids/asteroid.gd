extends Node2D
class_name Asteroid
@onready var sprite_2d = $Sprite2D
var speed : float
var rotation_speed : float
var move_upwards : bool
enum Type {Big,Med,Small}
var current_type : Type
var score : int 
const EXPLOSION = preload("res://scenes/explosion.tscn")
var random_x_direction: float

var random_rotation_number : float
var random_rotation_direction : int

const POWER_EXTRA_LIFE = preload("res://powerup/power_extra_life.tscn")
const POWER_FIRE_RATE = preload("res://powerup/power_fire_rate.tscn")
const POWER_TRIPLE_SHOOT = preload("res://powerup/power_triple_shoot.tscn")
const POWER_SHIELD = preload("res://powerup/power_shield.tscn")
var powerups : Array[PackedScene] = [POWER_TRIPLE_SHOOT, POWER_FIRE_RATE, POWER_EXTRA_LIFE, POWER_SHIELD]


signal destroyed

func _ready():
	random_rotation_number = randf_range(0,1)
	if random_rotation_number > 0.5:
		random_rotation_direction = 1
	elif random_rotation_number <= 0.5:
		random_rotation_direction = -1
	speed = randf_range(50,100)
	rotation_speed = randf_range(0.1,0.15)


func _physics_process(delta):
	sprite_2d.rotate(rotation_speed * random_rotation_direction)
	move_local_x(delta * random_rotation_direction * speed)
	if move_upwards:
		move_local_y(delta * 1 * speed)
	elif !move_upwards:
		move_local_y(delta * -1 * speed)
	
func _on_area_2d_area_entered(area):
	var new_position : Vector2
	match area.name:
		"Up":
			new_position = Vector2(position.x,631)
			teleport_to(new_position)
		"Down":
			new_position = Vector2(position.x,7)
			teleport_to(new_position)
		"Left":
			new_position = Vector2(1132,position.y)
			teleport_to(new_position)
		"Right":
			new_position = Vector2(10,position.y)
			teleport_to(new_position)
		"Bullet":
			destroy(true)
		"Shield":
			destroy(false)
			
func teleport_to(new_position : Vector2):
		position = new_position

func destroy(childs: bool):
	ScoreManager.give_score_amount(score)
	var explosion = EXPLOSION.instantiate() as Node2D
	explosion.position = position
	get_parent().add_child(explosion)
	var powerup_instance = powerups.pick_random().instantiate()
	powerup_instance.position = global_position
	get_parent().add_child.call_deferred(powerup_instance)
	if childs:
		generate_child_asteroids()
	emit_signal("destroyed", self)
	
	queue_free()
	
	
func generate_child_asteroids():
	pass
		
	
