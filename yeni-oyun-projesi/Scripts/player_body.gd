extends CharacterBody2D

# 3x3 grid centered with each square 150x150
var grid_positions = [
	[Vector2(300, 300), Vector2(450, 300), Vector2(600, 300)],
	[Vector2(300, 450), Vector2(450, 450), Vector2(600, 450)],
	[Vector2(300, 600), Vector2(450, 600), Vector2(600, 600)]
]

var current_row := 1
var current_col := 1  # Start at center

func _ready():
	global_position = grid_positions[current_row][current_col]

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
	global_position = grid_positions[current_row][current_col]
