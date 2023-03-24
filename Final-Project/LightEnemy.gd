# https://www.youtube.com/watch?v=WJfjnwxM0Do

# extends "res://Character.gd"
extends KinematicBody2D

var speed = 20
var motion = Vector2()
var gravity = 20
var direction = 1 # 1 = right, -1 = left

func _physics_process(delta):
	motion.y += gravity
	motion.x += speed * direction
	
#	if is_on_wall():
#		direction = direction * -1
		
	motion = move_and_slide(motion)
	
func is_on_wall():
	print("Wall")
	

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
