extends Node2D

var Vanderfeld = preload("res://RigidBody2D.tscn").instance()
onready var scoring = get_node("/root/ScoringAndData")

export var stopwatch = 0
var showStopwatch = true

func _ready():
	add_child(Vanderfeld)
	Vanderfeld.move_local_x(7608)
	Vanderfeld.move_local_y(-7170)
	Vanderfeld.gravity_scale = 3
	Vanderfeld.get_children()[0].visible = true
	Vanderfeld.get_children()[1].disabled = false
	
	$LevelScoreTimer.start()

func _on_LevelScoreTimer_timeout():
	stopwatch += 1
	$HUD.update_score(stopwatch)
	
func _process(_delta):
	if Input.is_action_just_released("ui_focus_next"):
		if(showStopwatch):
			get_node("/root/Main Scene/HUD/LevelScoreLabel").hide()
			showStopwatch = false;
		elif(!showStopwatch):
			get_node("/root/Main Scene/HUD/LevelScoreLabel").show()
			showStopwatch = true;
	if Input.is_action_pressed("respawn"):
		$Player.die()

func _on_End_Flag_body_entered(body):
	if body == $Player:
		if stopwatch < scoring.level1Best || scoring.level1Best == 0:
			scoring.level1Best = stopwatch
			print(scoring.level1Best)
		
		$HUD.level_beaten()
		$LevelScoreTimer.stop()
		$"Level Complete".play()
		
	

func _on_Checkpoints_body_shape_entered(_body_rid, body, _body_shape_index, local_shape_index):
	if body.name == "Player":
		if local_shape_index > $Player.curr_checkpoint:
			$Player.curr_checkpoint = local_shape_index
