extends CharacterBody2D

# 3x3 grid positions in a 450x450 area
var grid_positions = [
	[Vector2(75, 75), Vector2(225, 75), Vector2(375, 75)],
	[Vector2(75, 225), Vector2(225, 225), Vector2(375, 225)],
	[Vector2(75, 375), Vector2(225, 375), Vector2(375, 375)]
]

var current_row := 1
var current_col := 1

var target_position: Vector2
var speed := 600.0  # pixels per second

func _ready():
	# Start at the center of the grid
	target_position = grid_positions[current_row][current_col]
	global_position = target_position

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		jump_to_clicked_cell(event.position)

func jump_to_clicked_cell(mouse_pos: Vector2):
	var col = int(mouse_pos.x / 150)
	var row = int(mouse_pos.y / 150)

	row = clamp(row, 0, 2)
	col = clamp(col, 0, 2)

	current_row = row
	current_col = col

	target_position = grid_positions[row][col]

func _physics_process(delta):
	# Move toward the target position smoothly
	var direction = (target_position - global_position).normalized()
	var distance = global_position.distance_to(target_position)

	if distance > 1:
		var movement = direction * speed * delta
		if movement.length() > distance:
			movement = target_position - global_position
		move_and_collide(movement)
