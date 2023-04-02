extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Level1Button/Sprite.modulate = Color(0, 0, 0)
	$"Menu Music".play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_Level1Button_button_up():
	var _d = get_tree().change_scene("res://Main Scene.tscn")
	$"Menu Music".stop()

func _on_Level2Button_button_up():
	var _d = get_tree().change_scene("res://Level_2.tscn")
	
func _on_Level3Button_button_up():
	pass # Replace with function body.
