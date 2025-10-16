extends Node2D
@onready var asteroid_generator = $"../AsteroidGenerator"
@onready var asteroid_generator_2 = $"../AsteroidGenerator2"

var wave: int = 0
var num_asteroids: int = 4
var game_speed: float = 1.0

func _ready():
	wave_generator(wave)

func wave_generator(wave: int):
	asteroid_generator.generate_wave(num_asteroids / 2,game_speed)
	asteroid_generator_2.generate_wave(num_asteroids / 2,game_speed)
	#TODO: Comprobar que el array de asteroides esta vacio
	wave += 1
	increase_difficulty(wave)
		
func _process(delta):
	if asteroid_generator.asteroids.size() == 0 and asteroid_generator_2.asteroids.size() == 0:
		wave_generator(wave)
		

func increase_difficulty(wave: int):
	num_asteroids = num_asteroids + (wave * 1.5)
