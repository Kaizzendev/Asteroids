extends Node2D

@onready var crash_1 = $Crash1
@onready var crash_2 = $Crash2
@onready var crash_3 = $Crash3
@onready var shoot = $Shoot
@onready var throtle = $Throtle
@onready var big_ufo = $BigUfo
@onready var mini_ufo = $MiniUfo
@onready var die_ufo =  $DieUfo
@onready var player_die = $PlayerDie
@onready var space = $Space

func _ready():
	space.play()

func play_big_crash():
	crash_1.play() 

func play_med_crash():
	crash_2.play()
	
func play_small_crash():
	crash_3.play()

func play_throtle():
	throtle.play()

func play_shoot_bullet():
	shoot.play()
	
func play_big_ufo():
	big_ufo.play()
	
func stop_big_ufo():
	big_ufo.stop()

func play_mini_ufo():
	mini_ufo.play()
	
func stop_mini_ufo():
	mini_ufo.stop()
	
func play_die_ufo():
	die_ufo.play()
	
func play_player_die():
	player_die.play()
