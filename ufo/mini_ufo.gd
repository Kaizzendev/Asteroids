extends Ufo

@onready var marker_2d = $Marker2D
var is_shooting : bool = false
const BULLET = preload("res://player/ufo_bullet.tscn")
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioController.play_mini_ufo()
	score = 3000

func _process(delta):
	super(delta)
	if player.global_position.y <= marker_2d.global_position.y:
		marker_2d.position = Vector2(marker_2d.position.x, -20)
	elif player.global_position.y >= marker_2d.global_position.y:
		marker_2d.position = Vector2(marker_2d.position.x, 20)

func _physics_process(delta):
	if is_shooting:
		return
	else:
		is_shooting = true
		await get_tree().create_timer(2.0).timeout
		shoot()
		is_shooting = false

func death(byPlayer : bool):
	AudioController.stop_mini_ufo()
	super(byPlayer)

func _on_ufo_area_entered(area):
	if area.name == "Bullet":
		death(true)
	else:
		death(false)
	
func shoot():
	var bullet_instance = BULLET.instantiate() as Node2D
	var bullet_direction : Vector2 = player.global_position - marker_2d.global_position
	bullet_instance.global_position = marker_2d.global_position
	bullet_instance.direction = bullet_direction.normalized()
	get_parent().add_child(bullet_instance)
	AudioController.play_shoot_bullet()
