extends Node2D

var grid_size = 150  # Size of each grid cell

func draw_3x3_grid():
	for i in range(0, 4):
		draw_line(Vector2(225, 225 + (150 * i)), Vector2(675, 225 + (150 * i)), Color.GREEN, 1.0)
	for i in range(0, 4):
		draw_line(Vector2(225 + (150 * i), 225), Vector2(225 + (150 * i), 675), Color.GREEN, 1.0)
	#draw_line(Vector2(0, 50), Vector2(450, 50), Color.GREEN, 1.0)
	#draw_line(Vector2(7.5, 1.0), Vector2(7.5, 4.0), Color.GREEN, 1.0)

func draw_5x5_grid():
	var screen_center = Vector2(450, 450)  # Center of a 900x900 screen
	var grid_origin = screen_center - Vector2(grid_size * 2.5, grid_size * 2.5)  # Offset by 2.5 cells to center 5x5 grid

	# Draw horizontal lines (6 lines to make 5 rows)
	for i in range(6):
		var y = grid_origin.y + grid_size * i
		var start_pos = Vector2(grid_origin.x, y)
		var end_pos = Vector2(grid_origin.x + grid_size * 5, y)
		draw_line(start_pos, end_pos, Color.GREEN, 1.0)

	# Draw vertical lines (6 lines to make 5 columns)
	for i in range(6):
		var x = grid_origin.x + grid_size * i
		var start_pos = Vector2(x, grid_origin.y)
		var end_pos = Vector2(x, grid_origin.y + grid_size * 5)
		draw_line(start_pos, end_pos, Color.GREEN, 1.0)

func _draw() -> void:
	draw_3x3_grid()
	draw_5x5_grid()
