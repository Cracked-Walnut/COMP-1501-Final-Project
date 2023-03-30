extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Level1Button/Sprite.modulate = Color(0, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Level1Button_button_up():
	get_tree().change_scene("res://Main Scene.tscn")

func _on_Level2Button_button_up():
	pass # Replace with function body.
	
func _on_Level3Button_button_up():
	pass # Replace with function body.
