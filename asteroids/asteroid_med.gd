extends Asteroid
const ASTEROID_SMALL = preload("res://asteroids/asteroid_small.tscn")

func _ready():
	super()
	current_type = Type.Small
	score = 200

func generate_child_asteroids():
	var new_asteroid_instance : Node2D
	var random = randf_range(0,1)
	var random2 = randf_range(0,1)
	var quantity : int
	if random > 0.5:
		quantity = 1
	elif random <= 0.5:
		quantity = 0
		
	if quantity == 1:
		if random2 >= 0.5:
			new_asteroid_instance = ASTEROID_SMALL.instantiate() as Node2D
			new_asteroid_instance.global_position = position 
			get_parent().add_child.call_deferred(new_asteroid_instance)
		
func destroy():
	AudioController.play_med_crash()
	super()
