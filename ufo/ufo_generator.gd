extends Node2D

const MINI_UFO = preload("res://ufo/mini_ufo.tscn")
const BIG_UFO = preload("res://ufo/Big_ufo.tscn")
var ufos : Array[PackedScene]
var ufo_instance : Node2D = null

func _ready():
	loadUfos()
	await  get_tree().create_timer(15).timeout
	spawnUfo()
	for x in 100:
		await get_tree().create_timer(20).timeout
		spawnUfo()

	
func loadUfos():
	ufos.append(MINI_UFO)
	ufos.append(BIG_UFO)
	
func spawnUfo():
	ufo_instance = ufos.pick_random().instantiate() as Node2D
	positionUfo(ufo_instance)
	
func positionUfo(ufo : Node2D):
	var random = randf_range(0,1)
	if(random > 0.5):
		ufo.global_position = position
	else:
		ufo.global_position = Vector2(position.x, 530)
	get_parent().add_child.call_deferred(ufo)
