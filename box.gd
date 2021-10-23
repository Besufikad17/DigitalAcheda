extends Node2D


func _on_Area2D_body_entered(body):
	$".".remove_child($CollisionShape2D)
	$".".remove_child($Sprite)
