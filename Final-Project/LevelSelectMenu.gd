extends Control

onready var scoring = get_node("/root/ScoringAndData")

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Menu Music".play()
	if scoring.level1Best == 0:
		$Level1Button/Sprite.modulate = Color(0, 0, 0)
	elif scoring.level1Best < 180 && scoring.level1Best > 90:
		$Level1Button/Sprite/Star2.modulate = Color(1, 1, 1)
		$Level1Button/Sprite/Star1.modulate = Color(1, 1, 1)
	elif scoring.level1Best <= 90:
		$Level1Button/Sprite/Star1.modulate = Color(1, 1, 1)
		$Level1Button/Sprite/Star2.modulate = Color(1, 1, 1)
		$Level1Button/Sprite/Star3.modulate = Color(1, 1, 1)
	elif scoring.level1Best >= 180:
		$Level1Button/Sprite/Star1.modulate = Color(1, 1, 1)
		
	if scoring.level2Best == 0:
		$Level2Button/Sprite.modulate = Color(0, 0, 0)
	elif scoring.level2Best < 180 && scoring.level2Best > 90:
		$Level2Button/Sprite/Star2.modulate = Color(1, 1, 1)
		$Level2Button/Sprite/Star1.modulate = Color(1, 1, 1)
	elif scoring.level2Best <= 90:
		$Level2Button/Sprite/Star1.modulate = Color(1, 1, 1)
		$Level2Button/Sprite/Star2.modulate = Color(1, 1, 1)
		$Level2Button/Sprite/Star3.modulate = Color(1, 1, 1)
	elif scoring.level2Best >= 180:
		$Level2Button/Sprite/Star1.modulate = Color(1, 1, 1)
		
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
