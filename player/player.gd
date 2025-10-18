extends CharacterBody2D
class_name Player

@onready var marker_2d = $Marker2D
@onready var sprite_2d = $Sprite2D

@export var speed: int = 200
@export var rotation_speed: int = 200
var direction = Vector2.ZERO
var bullet_cap = []
@onready var animated_sprite_2d = $AnimatedSprite2D
const BULLET = preload("res://scenes/bullet.tscn")
const EXPLOSION = preload("res://scenes/explosion.tscn")
enum State { Rotate, Thrust, Idle, Shoot}
var current_state : State
var thrust = Vector2.ZERO
var can_shoot: bool
var bullet_cap_size: int = 4
var shoot_cooldown: float = 0.3

@export var triple_shot_active := false
@export var triple_spread_angle := 20.0 # grados entre las balas laterales


var power_ups: Array[Powerup]

func _ready():
	can_shoot = true
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
	if Input.is_action_just_pressed("interact") and can_shoot:
		if(bullet_cap.size() == bullet_cap_size):
			await get_tree().create_timer(shoot_cooldown).timeout
			bullet_cap.clear()
		else:
			current_state = State.Shoot
			AudioController.play_shoot_bullet()
			
			if triple_shot_active:
				_shoot_triple()
			else:
				_shoot_single()
			

func _shoot_single():
	var bullet_instance = BULLET.instantiate() as Node2D
	bullet_cap.append(bullet_instance)

	var bullet_direction: Vector2 = marker_2d.global_position - global_position
	bullet_instance.global_position = marker_2d.global_position
	bullet_instance.direction = bullet_direction.normalized()
	bullet_instance.speed_boost = velocity.length()
	get_parent().add_child(bullet_instance)


func _shoot_triple():
	var spread_radians = deg_to_rad(triple_spread_angle)
	var directions = [
		marker_2d.global_position - global_position,
		(marker_2d.global_position - global_position).rotated(-spread_radians),
		(marker_2d.global_position - global_position).rotated(spread_radians)
	]

	for dir in directions:
		var bullet_instance = BULLET.instantiate() as Node2D
		bullet_cap.append(bullet_instance)
		bullet_instance.global_position = marker_2d.global_position
		bullet_instance.direction = dir.normalized()
		bullet_instance.speed_boost = velocity.length()
		get_parent().add_child(bullet_instance)


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
		"Ufo":
			death()
		"Powerup":
			power_ups.append(area.get_parent())

	
func teleport_to(new_position : Vector2):
		position = new_position

func death():
	var explosion = EXPLOSION.instantiate() as Node2D
	explosion.position = position
	get_parent().add_child(explosion)
	can_shoot = false
	AudioController.play_player_die()
	AudioController.stop_big_ufo()
	AudioController.stop_mini_ufo()
	sprite_2d.hide()
	await get_tree().create_timer(1).timeout
	if(GameManager.lives <= 0):
		GameManager.lives = 3
		
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
	else:
		GameManager.lives  -= 1
		get_tree().change_scene_to_file("res://scenes/level.tscn")
