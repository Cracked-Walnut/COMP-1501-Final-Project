extends "res://Character.gd"

#Constants
const TOP_JUMP_TIME = 0.1

#Status Checks
var spear_in_ground = false
var grounded = false
var can_move = true

#Parameters
var spear_rotation_speed = 20
var jump_time = TOP_JUMP_TIME

#References
var spear_contact_static_body

func _ready():
	#Connect Signals
	$Spear.connect("tip_touched", self, "on_spear_tip_touched")
	$Spear.connect("turn_tip_on", self, "on_timer_timeout")

func _process(delta):
	#Get input for actions (not movement)
	if Input.is_action_just_pressed("ui_thrust"):
		thrust_spear()
	if Input.is_action_just_pressed("ui_release"):
		remove_spear_from_ground()
		

func _physics_process(delta):
	
	#Spear Control (Regular)
	if $Spear.get_angle_to(get_global_mouse_position()) != 0:
		$Spear.set_angular_velocity($Spear.get_angle_to(get_global_mouse_position())*spear_rotation_speed)
	else:
		$Spear.set_angular_velocity(0)

	#How to lift the spear from the ground
	# This code causes a lot of weird stuff
	# Until we get it fixed, right click to release spear from ground
	
	#if spear_in_ground and grounded and Input.get_last_mouse_speed().y < 0:
	#	remove_spear_from_ground()


#This function sends movement data to the parent class
func apply_movement(state):
	if Input.is_action_pressed("ui_left") and can_move:
		movement_direction += DIRECTION.LEFT
	if Input.is_action_pressed("ui_right") and can_move:
		movement_direction += DIRECTION.RIGHT
	if Input.is_action_pressed("ui_accept") and jump_time < TOP_JUMP_TIME and can_move:
		movement_direction += DIRECTION.UP
		jump_time += state.get_step()
	elif Input.is_action_just_released("ui_accept"):
		jump_time = TOP_JUMP_TIME
		pass
	if(grounded):
		jump_time = 0
	else:
		jump_time = TOP_JUMP_TIME

	if state.get_linear_velocity().y >0:
		launching = false

#Grounded Check
func _on_Feet_body_entered(body):
	var groups = body.get_groups()
	if groups.has("ground"):
		grounded = true


#Not Grounded Check
func _on_Feet_body_exited(body):
	var groups = body.get_groups()
	
	if groups.has("ground"):
		grounded = false


#Called when the spear tip touches something
func on_spear_tip_touched(body):
	var groups = body.get_groups()
	
	if groups.has("spearable"):
		spear_now_in_ground()


#Called if what the spear touched was the ground
func spear_now_in_ground():
	gravity_scale = 0
	spear_in_ground = true
	spear_contact_static_body = StaticBody2D.new()
	get_tree().get_root().add_child(spear_contact_static_body)
	spear_contact_static_body.global_position = $Spear/ContactPinJoint.global_position
	$Spear/ContactPinJoint.node_b = spear_contact_static_body.get_path()
	spear_rotation_speed = 150
	can_move = false


#Called when the spear is removed from the ground
func remove_spear_from_ground():
	$Spear/ContactPinJoint.set_node_b($Spear/ContactPinJoint/ProxyRigidBody.get_path())
	gravity_scale = 40
	spear_in_ground = false
	spear_rotation_speed = 20
	can_move = true
	
	# turn off tip collision for a bit
	$Spear.get_children()[3].start()
	$Spear.get_children()[1].disabled = true

func thrust_spear():
	
	if spear_in_ground:
		spear_launch()
	
	thrust_animation()

func thrust_animation():
	#play sprite animation
	
	pass

func spear_launch():
	launching = true
	remove_spear_from_ground()
	spear_contact_static_body.queue_free()
	apply_central_impulse(($Spear.global_position - get_global_mouse_position()).normalized() *20000)
	
	
# turn on tip collision
func on_timer_timeout():
	$Spear.get_children()[1].disabled = false
	
