extends CharacterBody2D

# 3x3 grid (each square = 150x150)
var grid_positions = [
	[Vector2(75, 75), Vector2(225, 75), Vector2(375, 75)],
	[Vector2(75, 225), Vector2(225, 225), Vector2(375, 225)],
	[Vector2(75, 375), Vector2(225, 375), Vector2(375, 375)]
]

var current_row := 1
var current_col := 1

var target_position: Vector2
var speed := 600.0

func _ready():
	target_position = grid_positions[current_row][current_col]
	global_position = target_position

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_W:
			move_to_cell(current_row - 1, current_col)
		elif event.keycode == KEY_S:
			move_to_cell(current_row + 1, current_col)
		elif event.keycode == KEY_A:
			move_to_cell(current_row, current_col - 1)
		elif event.keycode == KEY_D:
			move_to_cell(current_row, current_col + 1)

func move_to_cell(row: int, col: int):
	current_row = clamp(row, 0, 2)
	current_col = clamp(col, 0, 2)
	target_position = grid_positions[current_row][current_col]

func _physics_process(delta):
	var direction = (target_position - global_position).normalized()
	var distance = global_position.distance_to(target_position)

	if distance > 1:
		var movement = direction * speed * delta
		if movement.length() > distance:
			movement = target_position - global_position
		move_and_collide(movement)
