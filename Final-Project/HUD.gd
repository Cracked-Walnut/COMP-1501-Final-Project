extends CanvasLayer



func update_score(stopwatch):
	var tens = str(int(floor(stopwatch/10))%10)
	if(int(tens) > 5):
		tens = "0"
	var string = str(floor(stopwatch/60)) + ": " + tens + str(stopwatch%10)
	$LevelScoreLabel.text = string
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
