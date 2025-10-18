extends Powerup

func use_powerup(player: Player):
	super(player)
	duration = 8
	player.triple_shot_active = true
	await get_tree().create_timer(duration).timeout
	player.triple_shot_active = false
	queue_free()
