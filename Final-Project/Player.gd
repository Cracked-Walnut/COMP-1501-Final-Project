extends "res://Character.gd"

#Constants
const TOP_JUMP_TIME = 0.1

#Status Checks
var spear_in_ground = false
var can_move = true
var grounded = false
var can_be_hit = true
var falling = false
var spear_has_enemy = false

#Parameters
var spear_rotation_speed = 20
var jump_time = TOP_JUMP_TIME
var curr_checkpoint = 0
var thrustAnimating = false
var thrustAnimationFrames = 0

#References
var spear_contact_static_body
var enemy_on_spear

func _ready():
	#Connect Signals
	var _d = $Spear.connect("tip_touched", self, "on_spear_tip_touched")
	var _e = $Spear.connect("turn_tip_on", self, "on_timer_timeout")
	

func _process(_delta):
	#Get input for actions (not movement)
	if Input.is_action_just_pressed("ui_thrust"):
		thrust_spear()
	if Input.is_action_just_pressed("ui_release"):
		if spear_in_ground:
			remove_spear_from_ground()
		if spear_has_enemy:
			remove_spear_from_enemy()
		
	for collision in $Feet.get_overlapping_bodies():
		var groups = collision.get_groups()
		if groups.has("ground"):
			grounded = true
		
	if thrustAnimating:
		if thrustAnimationFrames <=2:
			$Spear/Shaft/Sprite.position.x += 10
			$Spear/Tip/Sprite.position.x += 10
		else:
			$Spear/Shaft/Sprite.position.x -= 10
			$Spear/Tip/Sprite.position.x -= 10
		thrustAnimationFrames += 1
		if thrustAnimationFrames >= 6:
			thrustAnimationFrames = 0
			thrustAnimating = false
			
func _physics_process(_delta):
	
	#Spear Control (Regular)
	if $Spear.get_angle_to(get_global_mouse_position()) != 0:
		$Spear.set_angular_velocity($Spear.get_angle_to(get_global_mouse_position())*spear_rotation_speed)
	else:
		$Spear.set_angular_velocity(0)
				
	#How to lift the spear from the ground
	if spear_in_ground and grounded and Input.get_last_mouse_speed().y < 0:
		remove_spear_from_ground()
		
	#Stop the enemy from rotating weirdly when on spear tip
	if spear_has_enemy:
		enemy_on_spear.rotation = $Spear.rotation

	


#This function sends movement data to the parent class
func apply_movement(state):
	
	if Input.is_action_pressed("ui_left") and can_move:
		movement_direction += DIRECTION.LEFT
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.animation = "Run"
		
	if Input.is_action_pressed("ui_right") and can_move:
		movement_direction += DIRECTION.RIGHT
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation = "Run"
		
	if Input.is_action_pressed("ui_accept") and jump_time < TOP_JUMP_TIME and can_move:
		movement_direction += DIRECTION.UP
		jump_time += state.get_step()
		$AnimatedSprite.animation = "Up"
		if !$Jump.playing:
			$Jump.play()
		
	elif Input.is_action_just_released("ui_accept"):
		jump_time = TOP_JUMP_TIME
		
	if(grounded):
		jump_time = 0
		if(!Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right")):
			$AnimatedSprite.animation = "Idle"
	
	else:
		jump_time = TOP_JUMP_TIME
		

	if state.get_linear_velocity().y >0 and movement_direction.x !=0 or grounded:
		launching = false
		
	if state.get_linear_velocity().y > 0 and !grounded:
		$AnimatedSprite.animation = "Down"
	

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
	
	if !spear_has_enemy and !spear_in_ground:
		if groups.has("spearable"):
			spear_now_in_ground()
		
		if groups.has("Light_Enemy"):
			stick_enemy(body)


#Called if what the spear touched was the ground
func spear_now_in_ground():
	gravity_scale = 0
	spear_in_ground = true
	launching = false
	spear_contact_static_body = StaticBody2D.new()
	get_tree().get_root().add_child(spear_contact_static_body)
	spear_contact_static_body.global_position = $Spear/ContactPinJoint.global_position
	$Spear/ContactPinJoint.node_b = spear_contact_static_body.get_path()
	spear_rotation_speed = 180
	can_move = false
	$AnimatedSprite.animation = "Down"


#Called when the spear is removed from the ground
func remove_spear_from_ground():
	$Spear/ContactPinJoint.set_node_b($Spear/ContactPinJoint/ProxyRigidBody.get_path())
	gravity_scale = 40
	spear_in_ground = false
	spear_rotation_speed = 20
	can_move = true
	
	# turn off tip collision for a bit
	$Spear.get_node("SpearTipOffTimer").start()
	$Spear.get_node("Tip").set_deferred("disabled", true)
	
func remove_spear_from_enemy():
	if spear_has_enemy:
		$Spear/ContactPinJoint.set_node_b($Spear/ContactPinJoint/ProxyRigidBody.get_path())
		spear_has_enemy = false
		enemy_on_spear.gravity_scale = 40
		enemy_on_spear.mass = 10
		enemy_on_spear.rotation = 0
	
		# turn off tip collision for a bit
		$Spear.get_node("SpearTipOffTimer").start()
		$Spear.get_node("Tip").set_deferred("disabled", true)

func thrust_spear():
	
	if spear_in_ground:
		spear_launch()
	if spear_has_enemy:
		launch_enemy()
	
	thrust_animation()

func thrust_animation():
	thrustAnimating = true

func spear_launch():
	launching = true
	remove_spear_from_ground()
	spear_contact_static_body.queue_free()
	apply_central_impulse(($Spear.global_position - get_global_mouse_position()).normalized() *20000)
	$AnimatedSprite.animation = "Up"
	if !$"Spear Launch".playing:
		$"Spear Launch".play()
	
	
# turn on tip collision
func on_timer_timeout():
	$Spear.get_children()[1].disabled = false


func _on_Player_body_shape_entered(_body_rid, body, _body_shape_index, local_shape_index):
	#if the collision box that triggered this collision is Body
	if local_shape_index == 0:
		var groups = body.get_groups()
		if groups.has("Light_Enemy"):
			if body.alive:
				take_knockback(body)
				take_damage()
				start_invincibility_frames()
		if groups.has("Deadly"):
			
			# seems like the system needs to process the global position,
			# or else the player is teleported back to where they died.
			# Don't remove this variable declaration.
			var _d = global_position
			die()
			

func take_knockback(body):
	launching = true
	apply_central_impulse((global_position - body.global_position).normalized() *20000 + Vector2(0, -1000))

func start_invincibility_frames():
	can_be_hit = false
	$Invincibility_Timer.start(1.5)

func _on_Invincibility_Timer_timeout():
	can_be_hit = true;
	pass

func take_damage():
	health = health-1
	if health <= 0:
		die()
	$"Player Hit".play()
	
func die():
	var respawn_position = get_parent().get_node("Checkpoints").get_children()[curr_checkpoint].get_node("RespawnAt")
	self.set_global_position(respawn_position.get_global_position())
	
	$Spear.set_global_position(respawn_position.get_global_position())
	health = 3
	grounded = false
	if !$"Player Hit".playing:
		$"Player Hit".play()
		
	remove_spear_from_ground()
	remove_spear_from_enemy()

func stick_enemy(body):
	$Spear/ContactPinJoint.node_b = body.get_path()
	body.gravity_scale = 0
	body.mass = 0.1
	body.stick_to_spear_tip()
	spear_has_enemy = true
	enemy_on_spear = body

func launch_enemy():
	enemy_on_spear.launching = true
	remove_spear_from_enemy()
	enemy_on_spear.apply_central_impulse(($Spear.global_position - get_global_mouse_position()).normalized() * -200)
