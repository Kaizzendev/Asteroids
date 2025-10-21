extends Powerup

const SHIELD = preload("res://powerup/shield.tscn")


func use_powerup(player: Player):
	super(player)
	duration = 10
	var shield = SHIELD.instantiate()
	player.add_child.call_deferred(shield)
	await get_tree().create_timer(duration).timeout
	shield.queue_free()
	queue_free()
