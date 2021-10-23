extends Node2D


var level_grid 

export var gw = 12
export var gh = 12
export var x_start = 0
export var y_start = 0
export var x_off = 48
export var y_off = 48

var player 
onready var pm = $PopupMenu

export var obstacles = [
	Vector2(0,3), Vector2(1,3), Vector2(1,4), Vector2(1,5), Vector2(1,6), 
	Vector2(2,5),Vector2(3,5), Vector2(3,6), Vector2(4,6) , Vector2(4,1),
	Vector2(4,2), Vector2(4,3), Vector2(4,0), Vector2(0,0), Vector2(1,0),  
	Vector2(2,0), Vector2(2,1), Vector2(6,0), Vector2(7,0), Vector2(8,0),   
	Vector2(5,6),Vector2(6,6),Vector2(6,5), Vector2(6,4), Vector2(6,3), 
	Vector2(6,2),Vector2(3,7), Vector2(3,8), Vector2(1,8), Vector2(1,9), 
	Vector2(1,10), Vector2(0,11), Vector2(3,11), Vector2(3,10),Vector2(4,10),
	Vector2(5,10), Vector2(5,9), Vector2(6,9), Vector2(5,8),  Vector2(7,9),
	 Vector2(8,9),  Vector2(8,10),  Vector2(10,0),  Vector2(10,1),  Vector2(10,2),
	 Vector2(10,3),  Vector2(10,4),  Vector2(10,5),  Vector2(10,6),  Vector2(10,7),
	 Vector2(10,8),  Vector2(10,9),  Vector2(10,10),  Vector2(9,0),  Vector2(8,2),
	 Vector2(8,3),  Vector2(8,4),  Vector2(8,5), Vector2(8,6),  Vector2(8,7), Vector2(11,0),
	Vector2(1,11),
	   
]

var tiles = [
	preload("res://Player.tscn"),
	preload("res://box.tscn"),
	preload("res://obstacles/tree.tscn"),
	preload("res://obstacles/stone.tscn")
]

func _ready():
	Global.high_score = 0
	Global.current_score = 0
	Global.time = 30
	var no_of_harvest = 200 - len(obstacles) 
	print(no_of_harvest)
	level_grid = []
	for i in range(gw):
		level_grid.append([])
		for j in range(gh):
			level_grid[i].append(0)
			
	draw_level()
	player = tiles[0].instance()
	var player_position = grid_to_pixel(1,1)
	player.position = Vector2(player_position[0], player_position[1])
	add_child(player)
	
	if Global.current_score == 156:
		pm.add_item("Congrats!!", 300)
		pm.popup_centered()
		get_tree().change_scene("res://UI.tscn")
	
		
func _process(delta):
	var count = 0
	$Label.text = "Score: " + str(Global.current_score)
	if Global.time >= 0:
		$Label2.text = str(Global.time) + "s remaining"
	elif Global.time < 0 and count <= 1:
		#$Timer.stop()
		print(count)
		pm.add_item("Time is up!!")
		pm.add_item("Retry (r) or Exit (e)")
		pm.popup_centered()
		if Input.is_action_pressed("exit"):
			get_tree().change_scene("res://UI.tscn")
		if Input.is_action_pressed("retry"):
			get_tree().change_scene("res://MainScene.tscn")
		count += 1
		
func grid_to_pixel(x, y):
	return Vector2(x * x_off + x_start, y * y_off + y_start)
	
func is_there_obstacle(x, y):
	for obstacle in obstacles:
		if obstacle.x == x and obstacle.y == y:
			return true
		
	
func draw_level():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var tile
	for i in range(gw):
		for j in range(gh):
			print(Global.current_score)
			var rand = rng.randi_range(2,4)
			if is_there_obstacle(i, j) and (i !=1 or j !=1):
				if rand == 2:
					tile = tiles[2].instance()
				else:
					tile = tiles[3].instance()
			else:
				tile = tiles[1].instance()
			add_child(tile)
			var pos = grid_to_pixel(i, j)
			tile.position = Vector2(pos[0], pos[1])



func _on_Timer_timeout():
	Global.time -= 1
	
