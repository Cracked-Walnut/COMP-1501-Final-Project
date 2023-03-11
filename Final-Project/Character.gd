extends RigidBody2D
#Abstract Class to represent characters that will all move

#Constants
const DIRECTION = {
	ZERO = Vector2(0,0),
	LEFT = Vector2(-1,0),
	RIGHT = Vector2(1,0),
	UP = Vector2(0,-1),
	DOWN = Vector2(0,1)}


#Parameters
export (int) var horizontal_acceleration = 400
export (int) var vertical_acceleration = 300
export (int) var top_move_speed = 400
export (int) var top_jump_speed = -800
export (int) var top_fall_speed = 1300

#State
var movement_direction = Vector2()
var launching = false


func _integrate_forces(state):
	var final_force = Vector2(0,0)

	movement_direction = DIRECTION.ZERO
	
	apply_movement(state)
	if launching:
		final_force.x = state.get_linear_velocity().x
		final_force.y = state.get_linear_velocity().y + movement_direction.y * vertical_acceleration
	else:
		final_force.x = movement_direction.x * horizontal_acceleration
		final_force.y = state.get_linear_velocity().y + movement_direction.y * vertical_acceleration
	
	if launching:
		pass
	else:
		final_force.x = clamp(final_force.x, -top_move_speed, top_move_speed)
		final_force.y = clamp(final_force.y, top_jump_speed, top_fall_speed)
		
	state.set_linear_velocity(final_force)
	
func apply_movement(state):
	#Abstract Method
	pass
