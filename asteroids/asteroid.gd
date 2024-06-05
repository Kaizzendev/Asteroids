extends Node2D
class_name Asteroid
@onready var sprite_2d = $Sprite2D
var speed : float
var rotation_speed : float
var move_upwards : bool
enum Type {Big,Med,Small}
var current_type : Type
var score : int 

var random_x_direction: float

var random_rotation_number : float
var random_rotation_direction : int

func _ready():
	random_rotation_number = randf_range(0,1)
	if random_rotation_number > 0.5:
		random_rotation_direction = 1
	elif random_rotation_number <= 0.5:
		random_rotation_direction = -1
	speed = randf_range(50,100)
	rotation_speed = randf_range(0.1,0.3)

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
			destroy()
			
func teleport_to(new_position : Vector2):
		position = new_position


func destroy():
	ScoreManager.give_score_amount(score)
	generate_child_asteroids()
	queue_free()
	
func generate_child_asteroids():
	pass
		
	
