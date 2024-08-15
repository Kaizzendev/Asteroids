extends Node2D

var asteroids : Array[PackedScene]
const ASTEROID_BIG_2 = preload("res://asteroids/asteroid_big_2.tscn")
const ASTEROID_BIG = preload("res://asteroids/asteroid_big.tscn")
const ASTEROID_BIG_3 = preload("res://asteroids/asteroid_big_3.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	loadAsteroids()
	for x in 100:
		generateRandomAsteroid()
		await get_tree().create_timer(3.0).timeout
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass
		
func loadAsteroids():
		asteroids.append(ASTEROID_BIG)
		asteroids.append(ASTEROID_BIG_2)
		asteroids.append(ASTEROID_BIG_3)
	
	
func generateRandomAsteroid():
	var asteroid_instance = asteroids.pick_random().instantiate() as Node2D
	asteroid_instance.global_position = position
	if position.y > 0:
		asteroid_instance.move_upwards = false
	elif position.y < 0:
		asteroid_instance.move_upwards = true
	get_parent().add_child.call_deferred(asteroid_instance)

