extends KinematicBody2D

var inputs = {
	"move_up":Vector2.UP,
	"move_down":Vector2.DOWN,
	"move_left":Vector2.LEFT,
	"move_right":Vector2.RIGHT
}

var moveSpeed = 250
var interactDist = 70
var vel = Vector2()
var facingDir = Vector2()

func _unhandled_input(event):
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move(dir)
			

func move(dir):
	if not is_on_ceiling() and not is_on_floor():
		position += inputs[dir] * 45
		Global.current_score += 1
		$AnimatedSprite.play("harvest")
		#$AnimatedSprite.play("default")
	

func end_game():
	print("ouch")
	if Global.current_score > Global.high_score:
		Global.high_score = Global.current_score
	get_tree().change_scene("res://UI.tscn")
		
	

