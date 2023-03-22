extends Camera2D

var target
export var speed = 0.03

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node("/root/Main Scene/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var offset_vector = Vector2(100,0)
	global_position = global_position.move_toward(target.global_position + offset_vector, (target.global_position-global_position).length() * speed)
