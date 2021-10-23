extends Area2D



func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		body.end_game()
