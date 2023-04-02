extends RigidBody2D

signal tip_touched
signal turn_tip_on

func _on_Spear_body_shape_entered(_body_rid, body, _body_shape_index, local_shape_index):
	#if the collision box that triggered this collision is Tip
	if local_shape_index == 1: 
		emit_signal("tip_touched", body)

func _on_SpearTipOffTimer_timeout():
	emit_signal("turn_tip_on")



