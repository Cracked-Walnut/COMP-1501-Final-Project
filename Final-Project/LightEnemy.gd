# https://www.youtube.com/watch?v=WJfjnwxM0Do

extends "res://Character.gd"

var direction = -1 # 1 for right, -1 for left
var can_change_direction = true

func apply_movement(state):
	top_move_speed = 150
	if direction == -1:
		movement_direction += DIRECTION.LEFT
		
	if direction == 1:
		movement_direction += DIRECTION.RIGHT
		
	print(direction)




func _on_Feet_body_entered(body):
	pass # Replace with function body.


func _on_LeftHitbox_body_entered(body):
	direction = 1
	can_change_direction = false
	$Walking_Hitbox_timer.start(0.5)


func _on_RightHitbox_body_entered(body):
	direction = -1
	can_change_direction = false
	$Walking_Hitbox_timer.start(0.5)


func _on_Walking_Hitbox_timer_timeout():
	can_change_direction = true
	pass # Replace with function body.
