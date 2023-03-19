extends Node2D

var Vanderfeld = preload("res://RigidBody2D.tscn").instance()

func _ready():
	add_child(Vanderfeld)
	Vanderfeld.move_local_x(7608)
	Vanderfeld.move_local_y(-7170)
	
	#Vanderfeld.gravity_scale = 3
	#Vanderfeld.get_children()[0].visible = true
	#Vanderfeld.get_children()[1].disabled = false
