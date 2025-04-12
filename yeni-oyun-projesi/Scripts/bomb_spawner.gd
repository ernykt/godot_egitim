extends Node2D
@onready var player: Node2D = $"../Player"
var bomb = preload("res://Scenes/Bomb.tscn")

# Küçük alan için (3x3 grid'in kenarları)
var spawnPosTopSmall = [Vector2(300, 0), Vector2(450, 0), Vector2(600, 0)]
var spawnPosLeftSmall = [Vector2(0, 300), Vector2(0, 450), Vector2(0, 600)]
var spawnPosRightSmall = [Vector2(900, 300), Vector2(900, 450), Vector2(900, 600)]
var spawnPosBotSmall = [Vector2(300, 900), Vector2(450, 900), Vector2(600, 900)]

# Büyük alan için (5x5 grid'in tüm kenarları)
var spawnPosTop = [Vector2(150, 0), Vector2(300, 0), Vector2(450, 0), Vector2(600, 0), Vector2(750, 0)]
var spawnPosLeft = [Vector2(0, 150), Vector2(0, 300), Vector2(0, 450), Vector2(0, 600), Vector2(0, 750)]
var spawnPosRight = [Vector2(900, 150), Vector2(900, 300), Vector2(900, 450), Vector2(900, 600), Vector2(900, 750)]
var spawnPosBot = [Vector2(150, 900), Vector2(300, 900), Vector2(450, 900), Vector2(600, 900), Vector2(750, 900)]


var spawnPosSelection = ["spawnPosTop", "spawnPosBot", "spawnPosLeft", "spawnPosRight"]
var spawnSelector = "spawnPosRight"

var horizontalVel = Vector2(500, 0)

func _on_timer_for_spawn_timeout() -> void:
	var bombInstance = bomb.instantiate()
	add_child(bombInstance, true)

	var use_extended = player.get_node("PlayerBody").powerup_collected 
	
	if spawnSelector == "spawnPosTop":
		var positions = spawnPosTop if use_extended else spawnPosTopSmall
		bombInstance.position = positions[randi_range(0, positions.size() - 1)]
		bombInstance.get_node("BombSprite").flip_v = true

	elif spawnSelector == "spawnPosBot":
		var positions = spawnPosBot if use_extended else spawnPosBotSmall
		bombInstance.position = positions[randi_range(0, positions.size() - 1)]
		bombInstance.get_node("BombSprite").flip_v = false
		bombInstance.velocity = -bombInstance.velocity

	elif spawnSelector == "spawnPosLeft":
		var positions = spawnPosLeft if use_extended else spawnPosLeftSmall
		bombInstance.position = positions[randi_range(0, positions.size() - 1)]
		bombInstance.get_node("BombSprite").rotation_degrees = 90
		bombInstance.velocity = horizontalVel

	elif spawnSelector == "spawnPosRight":
		var positions = spawnPosRight if use_extended else spawnPosRightSmall
		bombInstance.position = positions[randi_range(0, positions.size() - 1)]
		bombInstance.get_node("BombSprite").rotation_degrees = -90
		bombInstance.velocity = -horizontalVel


func _on_timer_for_spawn_pos_timeout() -> void:
	spawnSelector = spawnPosSelection[randi_range(0, spawnPosSelection.size() - 1)]
