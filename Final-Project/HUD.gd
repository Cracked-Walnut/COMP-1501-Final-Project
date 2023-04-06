extends CanvasLayer

func update_score(stopwatch):
	var tens = str(int(floor(stopwatch/10))%10)
	if(int(tens) > 5):
		tens = "0"
	var string = str(floor(stopwatch/60)) + ": " + tens + str(stopwatch%10)
	$LevelScoreLabel.text = string


# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelBeaten/Star1.modulate = Color(0, 0, 0)
	$LevelBeaten/Star2.modulate = Color(0, 0, 0)
	$LevelBeaten/Star3.modulate = Color(0, 0, 0)
	


func level_beaten():
	$LevelBeaten.visible = true
	
	if get_tree().get_current_scene().get_name() == "Main Scene":
		if get_owner().scoring.level1Best < 180 && get_owner().scoring.level1Best > 90:
			$LevelBeaten/Star1.modulate = Color(1, 1, 1)
			$LevelBeaten/Star2.modulate = Color(1, 1, 1)
		
		elif get_owner().scoring.level1Best <= 90:
			$LevelBeaten/Star1.modulate = Color(1, 1, 1)
			$LevelBeaten/Star2.modulate = Color(1, 1, 1)
			$LevelBeaten/Star3.modulate = Color(1, 1, 1)
			
		elif get_owner().scoring.level1Best >= 180:
			$LevelBeaten/Star1.modulate = Color(1, 1, 1)
	
	elif get_tree().get_current_scene().get_name() == "Level_2":
		$LevelBeaten.visible = false;
		if get_owner().scoring.level2Best < 180 && get_owner().scoring.level2Best > 90:
			$LevelBeaten/Star1.modulate = Color(1, 1, 1)
			$LevelBeaten/Star2.modulate = Color(1, 1, 1)
		
		elif get_owner().scoring.level2Best <= 90:
			$LevelBeaten/Star1.modulate = Color(1, 1, 1)
			$LevelBeaten/Star2.modulate = Color(1, 1, 1)
			$LevelBeaten/Star3.modulate = Color(1, 1, 1)
			
		elif get_owner().scoring.level2Best >= 180:
			$LevelBeaten/Star1.modulate = Color(1, 1, 1)

func _on_NextButton_button_up():
	if get_tree().get_current_scene().get_name() == "Main Scene":
		var _d = get_tree().change_scene("res://Level_2.tscn")
		


func _on_LevelSelect_button_up():
	
#		if get_owner().get_node("ScoringAndData").level1Best < 180 && get_owner().get_node("ScoringAndData").level1Best > 90:
#			get_owner().get_node("LevelSelectMenu/Level1Button/Sprite/Star1").modulate = Color(1, 1, 1)
#			get_owner().get_node("LevelSelectMenu/Level1Button/Sprite/Star2").modulate = Color(1, 1, 1)
#
#		elif get_owner().get_node("ScoringAndData").level1Best <= 90:
#			get_tree().get_root().get_node("/root/LevelSelectMenu/Level1Button/Sprite/Star1").modulate = Color(0, 0, 0)
#			get_tree().get_root().get_node("/root/LevelSelectMenu/Level1Button/Sprite/Star2").modulate = Color(0, 0, 0)
#			get_tree().get_root().get_node("/root/LevelSelectMenu/Level1Button/Sprite/Star3").modulate = Color(0, 0, 0)
#
#		elif get_owner().get_node("ScoringAndData").level1Best >= 180:
#			get_owner().get_node("LevelSelectMenu/Level1Button/Sprite/Star1").modulate = Color(1, 1, 1)
#
		var _d = get_tree().change_scene("res://LevelSelectMenu.tscn")
