extends Asteroid
const ASTEROID_MED = preload("res://asteroids/asteroid_med.tscn")
const ASTEROID_MED_2 = preload("res://asteroids/asteroid_med_2.tscn")

func _ready():
	super()
	current_type = Type.Big
	score = 100
	
func generate_child_asteroids():
	var new_asteroid_instance : Node2D
	var random = randf_range(0,1)
	var random2 = randf_range(0,1)
	var quantity : int
	if random > 0.5:
		quantity = 1
	elif random <= 0.5:
		quantity = 2
	for x in quantity:
		if random2 > 0.5:
			new_asteroid_instance = ASTEROID_MED.instantiate() as Node2D
		elif random2 <= 0.5:
			new_asteroid_instance = ASTEROID_MED_2.instantiate() as Node2D
			
		new_asteroid_instance.global_position = position
		get_parent().add_child.call_deferred(new_asteroid_instance)

func destroy(childs: bool):
	AudioController.play_big_crash()
	super(childs)
	
