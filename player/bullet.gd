extends Node2D
var direction : Vector2
@export var speed : int = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	position += direction * speed * delta
	destroy_bullet()

func _on_area_2d_area_entered(area : Area2D):
	var new_position : Vector2
	match area.name:
		"Up":
			new_position = Vector2(position.x,633)
			teleport_to(new_position)
		"Down":
			new_position = Vector2(position.x,6)
			teleport_to(new_position)
		"Left":
			new_position = Vector2(1140,position.y)
			teleport_to(new_position)
		"Right":
			new_position = Vector2(7,position.y)
			teleport_to(new_position)
		"Asteroid":
			queue_free()
		"Ufo":
			queue_free()
		"Player":
			queue_free()
			
func teleport_to(new_position : Vector2):
		position = new_position
		
func destroy_bullet():
		await get_tree().create_timer(1.0).timeout
		queue_free()
