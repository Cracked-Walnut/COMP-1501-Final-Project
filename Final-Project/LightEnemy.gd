# https://www.youtube.com/watch?v=WJfjnwxM0Do

extends "res://Character.gd"

var direction = 1 # 1 for right, -1 for left
var move_speed = 150
var move_velocity = Vector2(move_speed * direction, 0)
#var detect_ground_raycast = $Detect_Ground.force_raycast_update()

func _physics_process(delta):
	if !$Detect_Ground.is_colliding():
		direction *= -1
	
	if direction == 1:
		apply_central_impulse(Vector2(move_speed * direction, 0))
	else:
		apply_central_impulse(Vector2(move_speed * (-direction), 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
