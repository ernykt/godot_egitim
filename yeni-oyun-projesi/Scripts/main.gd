extends Node2D

@onready var player: Node2D = $Player
@onready var label: Label = $Label

#func _ready() -> void:
	#shield_powerup.connect("powerup_collected", _on_powerup_collected)
# Define the list of possible spawn positions
var spawn_positions := [
	[Vector2(300, 300), Vector2(450, 300), Vector2(600, 300)],
	[Vector2(300, 450), Vector2(450, 450), Vector2(600, 450)],
	[Vector2(300, 600), Vector2(450, 600), Vector2(600, 600)]
]

# Function to spawn the power-up
func _spawn_powerup(position: Vector2):
	var powerup = preload("res://Scenes/shield_powerup.tscn").instantiate()
	powerup.position = position
	add_child(powerup)

func _on_shield_spawn_timer_timeout() -> void:
	# Pick a random row from the spawn_positions list
	var random_row = spawn_positions[randi() % spawn_positions.size()]
	
	# Pick a random position from that row
	var random_position = random_row[randi() % random_row.size()]
	
	# Spawn the power-up at the random position
	_spawn_powerup(random_position)
