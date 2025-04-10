extends Node2D

var bomb = preload("res://Scenes/Bomb.tscn")
var spawnPosTop = [Vector2(300, 0), Vector2(450, 0), Vector2(600, 0)]
var spawnPosLeft = [Vector2(0, 300), Vector2(0, 450), Vector2(0, 600)]
var spawnPosRight = [Vector2(900, 300), Vector2(900, 450), Vector2(900, 600)]
var spawnPosBot = [Vector2(300, 900), Vector2(450, 900), Vector2(600, 900)]
var spawnPosSelection = ["spawnPosTop", "spawnPosBot", "spawnPosLeft", "spawnPosRight"]
var spawnSelector = "spawnPosRight"
var horizontalVel = Vector2(500, 0)

func _on_timer_for_spawn_timeout() -> void:
	var bombInstance = bomb.instantiate()
	add_child(bombInstance, true)
	if spawnSelector == "spawnPosTop":
		bombInstance.position = spawnPosTop[randi_range(0, 2)]
		bombInstance.get_node("BombSprite").flip_v = true
	if spawnSelector == "spawnPosBot":
		bombInstance.position = spawnPosBot[randi_range(0, 2)]
		bombInstance.get_node("BombSprite").flip_v = false
		bombInstance.velocity = -bombInstance.velocity
	if spawnSelector == "spawnPosLeft":
		bombInstance.position = spawnPosLeft[randi_range(0, 2)]
		bombInstance.get_node("BombSprite").rotation_degrees = 90
		bombInstance.velocity = horizontalVel
	if spawnSelector == "spawnPosRight":
		bombInstance.position = spawnPosRight[randi_range(0, 2)]
		bombInstance.velocity = -horizontalVel
		bombInstance.get_node("BombSprite").rotation_degrees = -90
	#bombInstance.position
	#print_debug(bombInstance.name)

func _on_timer_for_spawn_pos_timeout() -> void:
	spawnSelector = spawnPosSelection[randi_range(0, 3)]
	print(spawnSelector)
