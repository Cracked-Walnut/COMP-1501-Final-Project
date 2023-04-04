extends Node2D

var openDoor = preload("res://Open_Door.tscn").instance()
var light_enemy = preload("res://LightEnemy.tscn")
onready var scoring = get_node("/root/ScoringAndData")

var door_1_opened = false
var door_2_opened = false

var button2_pressed = false
var button3_pressed = false
var button4_pressed = false
var button5_pressed = false
var button6_pressed = false
var button7_pressed = false

var stopwatch = 0;
var showStopwatch = true

func _ready():
	$LevelScoreTimer.start()


func _process(_delta):
	if button2_pressed and button3_pressed and button4_pressed and button5_pressed and button6_pressed and button7_pressed and !door_2_opened:
		if !door_2_opened:
			$"Mechanisms/Door Open".play()
		door_2_opened = true
		
		add_child(openDoor)
		openDoor.global_position = $Mechanisms/ClosedDoor_2.position
		openDoor.global_position.x = openDoor.global_position.x +58
		openDoor.global_position.y = openDoor.global_position.y -78
		$Mechanisms/ClosedDoor_2.queue_free()
		
	if Input.is_action_pressed("respawn"):
		$Player.die()

func _on_LevelScoreTimer_timeout():
	stopwatch += 1
	$HUD.update_score(stopwatch)

func _on_Button_1_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy") and !door_1_opened:
		if !door_1_opened:
			$"Mechanisms/Door Open".play()
			
		door_1_opened = true
		$Mechanisms/Button_1.texture = preload("res://Textures/Button_Down.png")
		$"Mechanisms/Button Click".play()
		
		add_child(openDoor)
		openDoor.global_position = $Mechanisms/ClosedDoor_1.position
		openDoor.global_position.x = openDoor.global_position.x +58
		openDoor.global_position.y = openDoor.global_position.y -78
		$Mechanisms/ClosedDoor_1.queue_free()


func _on_Button2_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		if !button2_pressed:
			$"Mechanisms/Button Click".play()
		button2_pressed = true
		$Mechanisms/Button_2.texture = preload("res://Textures/Button_Down.png")
		



func _on_Button3_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		if !button3_pressed:
			$"Mechanisms/Button Click".play()
		button3_pressed = true
		$Mechanisms/Button_3.texture = preload("res://Textures/Button_Down.png")


func _on_Button4_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		if !button4_pressed:
			$"Mechanisms/Button Click".play()
		button4_pressed = true
		$Mechanisms/Button_4.texture = preload("res://Textures/Button_Down.png")


func _on_Button5_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		if !button5_pressed:
			$"Mechanisms/Button Click".play()
		button5_pressed = true
		$Mechanisms/Button_5.texture = preload("res://Textures/Button_Down.png")

func _on_Button6_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		if !button6_pressed:
			$"Mechanisms/Button Click".play()
		button6_pressed = true
		$Mechanisms/Button_6.texture = preload("res://Textures/Button_Down.png")

func _on_Button7_body_entered(body):
	var groups = body.get_groups()
	if groups.has("Light_Enemy"):
		if !button7_pressed:
			$"Mechanisms/Button Click".play()
		button7_pressed = true
		$Mechanisms/Button_7.texture = preload("res://Textures/Button_Down.png")


func _on_Enemy_Spawn_timer_timeout():
	var new_enemy = light_enemy.instance()
	add_child(new_enemy)	
	new_enemy.global_position.x = 7863
	new_enemy.global_position.y = -187

#func _on_End_Flag_body_entered(body):
	#if body == $Player:
	#	if stopwatch < $ScoringAndData.level1Best || $ScoringAndData.level1Best == 0:
	#		$ScoringAndData.level1Best = stopwatch
	#		print($ScoringAndData.level1Best)
	#	
	#	$HUD.level_beaten()
	#	$LevelScoreTimer.stop()
		
	

func _on_Checkpoints_body_shape_entered(_body_rid, body, _body_shape_index, local_shape_index):
	if body.name == "Player":
		if local_shape_index > $Player.curr_checkpoint:
			$Player.curr_checkpoint = local_shape_index
		
		if local_shape_index == 5:
			$Enemy_Spawn_timer.start()
			
func _on_End_Flag_body_entered(body):
	if body == $Player:
		if stopwatch < scoring.level2Best || scoring.level2Best == 0:
			scoring.level2Best = stopwatch
			print(scoring.level2Best)
		
		$HUD.level_beaten()
		$LevelScoreTimer.stop()
		$"Level Complete".play()
		
