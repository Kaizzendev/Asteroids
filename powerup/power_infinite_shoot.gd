extends Powerup

func use_powerup(player: Player):
	super(player)
	duration = 10
	player.bullet_cap_size = 20
	player.shoot_cooldown = 0
	await get_tree().create_timer(duration).timeout
	player.bullet_cap_size = 4
	player.shoot_cooldown = 0.2
	player.bullet_cap.clear()
	queue_free()
