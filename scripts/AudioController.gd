extends Node2D

@onready var crash_1 = $Crash1
@onready var crash_2 = $Crash2
@onready var crash_3 = $Crash3


func play_big_crash():
	crash_1.play() 

func play_med_crash():
	crash_2.play()
	
func play_small_crash():
	crash_3.play()
