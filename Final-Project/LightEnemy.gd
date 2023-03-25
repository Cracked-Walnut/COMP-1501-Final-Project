# https://www.youtube.com/watch?v=WJfjnwxM0Do

# extends "res://Character.gd"
extends KinematicBody2D

var velocity = Vector2(100, 0)

func _physics_process(delta):
#	velocity.y += 7
	
#	if is_on_wall():
#		velocity.x *= -1
		
	move_and_slide(velocity, Vector2(0, -1))
	
#func is_on_wall():
#	print("Wall")
	

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# ttfunc _process(delta):
#	pass
