extends Node2D

var openDoor = preload("res://Open_Door.tscn").instance()
var light_enemy = preload("res://LightEnemy.tscn")
var door_1_opened = false
var door_2_opened = false

var button2_pressed = false
var button3_pressed = false
var button4_pressed = false
var button5_pressed = false
var button6_pressed = false
var button7_pressed = false


func _process(delta):
	if button2_pressed and button3_pressed and button4_pressed and button5_pressed and button6_pressed and button7_pressed and !door_2_opened:
		door_2_opened = true
		
		add_child(openDoor)
		openDoor.global_position = $Mechanisms/ClosedDoor_2.position
		openDoor.global_position.x = openDoor.global_position.x +58
		openDoor.global_position.y = openDoor.global_position.y -78
		$Mechanisms/ClosedDoor_2.queue_free()


func _on_Button_1_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy") and !door_1_opened:
		door_1_opened = true
		$Mechanisms/Button_1.texture = preload("res://Textures/Button_Down.png")
		
		add_child(openDoor)
		openDoor.global_position = $Mechanisms/ClosedDoor_1.position
		openDoor.global_position.x = openDoor.global_position.x +58
		openDoor.global_position.y = openDoor.global_position.y -78
		$Mechanisms/ClosedDoor_1.queue_free()


func _on_Button2_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		button2_pressed = true
		$Mechanisms/Button_2.texture = preload("res://Textures/Button_Down.png")
		



func _on_Button3_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		button3_pressed = true
		$Mechanisms/Button_3.texture = preload("res://Textures/Button_Down.png")
		


func _on_Button4_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		button4_pressed = true
		$Mechanisms/Button_4.texture = preload("res://Textures/Button_Down.png")
		


func _on_Button5_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		button5_pressed = true
		$Mechanisms/Button_5.texture = preload("res://Textures/Button_Down.png")


func _on_Button6_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		button6_pressed = true
		$Mechanisms/Button_6.texture = preload("res://Textures/Button_Down.png")


func _on_Button7_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		button7_pressed = true
		$Mechanisms/Button_7.texture = preload("res://Textures/Button_Down.png")
		


func _on_Enemy_Spawn_timer_timeout():
	var new_enemy = light_enemy.instance()
	add_child(new_enemy)	
	new_enemy.global_position.x = 7863
	new_enemy.global_position.y = -187


func _on_Spawn_area_hitbox_body_entered(body):
	$Enemy_Spawn_timer.start()
