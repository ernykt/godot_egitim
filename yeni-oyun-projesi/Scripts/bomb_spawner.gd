extends Node2D

@onready var player: Node2D = $"../Player"
@onready var score: Timer = $"../Score"

var bomb = preload("res://Scenes/Bomb.tscn")
var INDICATOR = preload("res://Scenes/indicator.tscn")

# Small grid (3x3 edges)
var spawnPosTopSmall = [Vector2(300, 100), Vector2(450, 100), Vector2(600, 100)]
var spawnPosLeftSmall = [Vector2(100, 300), Vector2(100, 450), Vector2(100, 600)]
var spawnPosRightSmall = [Vector2(800, 300), Vector2(800, 450), Vector2(800, 600)]
var spawnPosBotSmall = [Vector2(300, 800), Vector2(450, 800), Vector2(600, 800)]

# Expanded grid (5x5 edges)
var spawnPosTop = [Vector2(150, 50), Vector2(300, 50), Vector2(450, 50), Vector2(600, 50), Vector2(750, 50)]
var spawnPosLeft = [Vector2(50, 150), Vector2(50, 300), Vector2(50, 450), Vector2(50, 600), Vector2(50, 750)]
var spawnPosRight = [Vector2(850, 150), Vector2(850, 300), Vector2(850, 450), Vector2(850, 600), Vector2(850, 750)]
var spawnPosBot = [Vector2(150, 850), Vector2(300, 850), Vector2(450, 850), Vector2(600, 850), Vector2(750, 850)]

var spawnPosSelection = ["spawnPosTop", "spawnPosBot", "spawnPosLeft", "spawnPosRight"]
var spawnSelector = "spawnPosRight"

var horizontalVel = Vector2(500, 0)
var verticalVel = Vector2(0, 500)

func _on_timer_for_spawn_timeout() -> void:
	show_indicator()

func _on_timer_for_spawn_pos_timeout() -> void:
	spawnSelector = spawnPosSelection[randi_range(0, spawnPosSelection.size() - 1)]

func show_indicator():
	var use_extended = player.get_node("PlayerBody").powerup_collected
	var positions := []
	var flip_v := false
	var rotation := 0.0
	var velocity := Vector2.ZERO
	var offset := Vector2.ZERO

	match spawnSelector:
		"spawnPosTop":
			positions = spawnPosTop if use_extended else spawnPosTopSmall
			flip_v = true
			velocity = verticalVel
			offset = Vector2(0, 0) if use_extended else Vector2(0, 10)
		"spawnPosBot":
			positions = spawnPosBot if use_extended else spawnPosBotSmall
			flip_v = false
			velocity = -verticalVel
			offset = Vector2(0, 0) if use_extended else Vector2(0, -10)
		"spawnPosLeft":
			positions = spawnPosLeft if use_extended else spawnPosLeftSmall
			rotation = 90
			velocity = horizontalVel
			offset = Vector2(0, 0) if use_extended else Vector2(10, 0)
		"spawnPosRight":
			positions = spawnPosRight if use_extended else spawnPosRightSmall
			rotation = -90
			velocity = -horizontalVel
			offset = Vector2(0, 0) if use_extended else Vector2(-10, 0)

	var selected_pos = positions[randi_range(0, positions.size() - 1)]

	# Spawn indicator
	var indicator_instance = INDICATOR.instantiate()
	add_child(indicator_instance)
	indicator_instance.position = selected_pos + offset

	# Wait a second
	await get_tree().create_timer(1.0).timeout

	# Remove indicator
	indicator_instance.queue_free()

	# Spawn bomb
	var bombInstance = bomb.instantiate()
	add_child(bombInstance, true)
	bombInstance.position = selected_pos
	bombInstance.get_node("BombSprite").flip_v = flip_v
	bombInstance.get_node("BombSprite").rotation_degrees = rotation
	bombInstance.velocity = velocity
