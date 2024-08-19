extends CharacterBody2D
@onready var marker_2d = $Marker2D

@export var speed: int = 200
@export var rotation_speed: int = 200
var direction = Vector2.ZERO
var bullet_cap = []
@onready var animated_sprite_2d = $AnimatedSprite2D
const BULLET = preload("res://player/bullet.tscn")
enum State { Rotate, Thrust, Idle, Shoot}
var current_state : State
var thrust = Vector2.ZERO

func _ready():
	current_state = State.Idle
	ScoreManager.give_score_amount(ScoreManager.total_score)
	
func _physics_process(delta: float):
	rotate_player(delta)
	impulse_player(delta)
	shoot()
	
	
	move_and_slide()
	
func rotate_player(delta):
	var rotation_direction = input_movement()
	if rotation_direction:
		rotation_degrees += rotation_speed * delta * rotation_direction
		current_state = State.Rotate

func impulse_player(delta):
	direction = Vector2.ZERO
	if Input.is_action_pressed("up"):
		direction = transform.y * speed
		velocity += -direction * delta
		current_state = State.Thrust
		animated_sprite_2d.show()
		animated_sprite_2d.play("gas")
		AudioController.play_throtle()
	else:
		animated_sprite_2d.stop()
		animated_sprite_2d.hide()
		
func shoot():
	if Input.is_action_just_pressed("interact"):
		if(bullet_cap.size() == 4):
			await get_tree().create_timer(0.1).timeout
			bullet_cap.clear()
		else:
			current_state = State.Shoot
			var bullet_instance = BULLET.instantiate() as Node2D
			bullet_cap.append(bullet_instance)
			var bullet_direction : Vector2 = marker_2d.global_position - global_position
			bullet_instance.global_position = marker_2d.global_position
			bullet_instance.direction = bullet_direction.normalized()
			get_parent().add_child(bullet_instance)
			AudioController.play_shoot_bullet()
		
		
func input_movement() -> float: 
	var rotation_direction: float = Input.get_axis("left","right")
	
	return rotation_direction

func _on_area_2d_area_entered(area):
	var new_position : Vector2
	match area.name:
		"Up":
			new_position = Vector2(position.x,633)
			teleport_to(new_position)
		"Down":
			new_position = Vector2(position.x,6)
			teleport_to(new_position)
		"Left":
			new_position = Vector2(1140,position.y)
			teleport_to(new_position)
		"Right":
			new_position = Vector2(7,position.y)
			teleport_to(new_position)
		"Asteroid":
			death()
		"Bullet":
			death()
			
func teleport_to(new_position : Vector2):
		position = new_position
		
func death():

	if(GameManager.lives <= 0):
		GameManager.lives = 3
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
	else:
		GameManager.lives  -= 1
		get_tree().change_scene_to_file("res://scenes/level.tscn")
	AudioController.stop_big_ufo()
	AudioController.stop_mini_ufo()
	
	
