extends Powerup

func use_powerup(player: Player):
	super(player)
	ScoreManager.give_extra_life()
	queue_free()
