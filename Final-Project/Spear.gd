extends RigidBody2D

signal tip_touched

func _on_Spear_body_entered(body):
	emit_signal("tip_touched", body)
