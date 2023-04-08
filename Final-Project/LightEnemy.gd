# https://www.youtube.com/watch?v=WJfjnwxM0Do

extends "res://Character.gd"

var direction = -1 # 1 for right, -1 for left
var can_change_direction = true
var stuck_to_spear = false
var spear_tip
var alive = true
var grounded = false

func apply_movement(_state):
	if alive:
		top_move_speed = 150
		if direction == -1:
			$AnimatedSprite.flip_h = true
			movement_direction += DIRECTION.LEFT
			
		if direction == 1:
			$AnimatedSprite.flip_h = false
			movement_direction += DIRECTION.RIGHT
	
	if !alive and grounded:
		movement_direction = DIRECTION.ZERO
		$AnimatedSprite.animation = "Dead"
	
	
func _process(_delta):
		for collision in $Feet.get_overlapping_bodies():
			var groups = collision.get_groups()
			if groups.has("ground"):
				grounded = true
	
func _on_Feet_body_exited(body):
	var groups = body.get_groups()
	
	if groups.has("ground"):
		grounded = false


func _on_LeftHitbox_body_entered(_body):
	direction = 1
	can_change_direction = false
	$Walking_Hitbox_timer.start(0.5)


func _on_RightHitbox_body_entered(_body):
	direction = -1
	can_change_direction = false
	$Walking_Hitbox_timer.start(0.5)


func _on_Walking_Hitbox_timer_timeout():
	can_change_direction = true
	pass # Replace with function body.
	
func stick_to_spear_tip():
	if alive == true:
		$"Enemy Killed".play()
	alive = false
