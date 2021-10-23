extends Control

func _ready():
	$Label2.text = "HighScore: " + str(Global.high_score)
func _process(delta):
	if Input.is_action_pressed("start"):
		get_tree().change_scene("res://MainScene.tscn")


