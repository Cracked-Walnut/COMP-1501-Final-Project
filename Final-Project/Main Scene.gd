extends Node2D

var Vanderfeld = preload("res://RigidBody2D.tscn").instance()

export var stopwatch = 0
var showStopwatch = true

func _ready():
	add_child(Vanderfeld)
	Vanderfeld.move_local_x(7608)
	Vanderfeld.move_local_y(-7170)
	
	$LevelScoreTimer.start()

func _on_LevelScoreTimer_timeout():
	stopwatch += 1
	$HUD.update_score(stopwatch)
	
func _process(delta):
	if Input.is_action_just_released("ui_focus_next"):
		if(showStopwatch):
			get_node("/root/Main Scene/HUD/LevelScoreLabel").hide()
			showStopwatch = false;
		elif(!showStopwatch):
			get_node("/root/Main Scene/HUD/LevelScoreLabel").show()
			showStopwatch = true;
		
		

	
	
	#Vanderfeld.gravity_scale = 3
	#Vanderfeld.get_children()[0].visible = true
	#Vanderfeld.get_children()[1].disabled = false
