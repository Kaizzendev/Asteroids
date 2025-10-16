extends Node2D

var asteroids : Array[Asteroid]
const ASTEROID_BIG_2 = preload("res://asteroids/asteroid_big_2.tscn")
const ASTEROID_BIG = preload("res://asteroids/asteroid_big.tscn")
const ASTEROID_BIG_3 = preload("res://asteroids/asteroid_big_3.tscn")

func generate_wave(num_asteroids: int, speed_difficulty: float):
	for i in num_asteroids:
		generateRandomAsteroid()
		await get_tree().create_timer(0.5).timeout


func generateRandomAsteroid():
	var asteroid_instance = [ASTEROID_BIG, ASTEROID_BIG_2, ASTEROID_BIG_3].pick_random().instantiate()
	asteroid_instance.global_position = position + Vector2(randi_range(-500,500),0)
	if position.y > 0:
		asteroid_instance.move_upwards = false
	elif position.y < 0:
		asteroid_instance.move_upwards = true
	asteroids.append(asteroid_instance)
	asteroid_instance.connect("destroyed", Callable(self, "_on_asteroid_destroyed"))


	get_parent().add_child.call_deferred(asteroid_instance)

func _on_asteroid_destroyed(emitter):
	asteroids.erase(emitter)
