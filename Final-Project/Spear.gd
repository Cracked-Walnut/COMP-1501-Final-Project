extends RigidBody2D

signal tip_touched
signal turn_tip_on

func _on_Spear_body_entered(body):
	emit_signal("tip_touched", body)


func _on_SpearTipOffTimer_timeout():
	emit_signal("turn_tip_on")
