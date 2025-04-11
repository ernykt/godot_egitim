extends CharacterBody2D
@onready var player_sprite: Sprite2D = $PlayerSprite

var grid_positions = [
	[Vector2(300, 300), Vector2(450, 300), Vector2(600, 300)],
	[Vector2(300, 450), Vector2(450, 450), Vector2(600, 450)],
	[Vector2(300, 600), Vector2(450, 600), Vector2(600, 600)]
]

var current_row := 1
var current_col := 1
var target_position: Vector2
var speed := 800.0
var is_moving := false

func _ready():
	target_position = grid_positions[current_row][current_col]
	global_position = target_position

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and not is_moving:
		var new_row = current_row
		var new_col = current_col

		# Handle movement and set sprite rotation
		if event.keycode == KEY_W:
			new_row -= 1
			player_sprite.rotation_degrees = -90
		elif event.keycode == KEY_S:
			new_row += 1
			player_sprite.rotation_degrees = 90
		elif event.keycode == KEY_A:
			new_col -= 1
			player_sprite.rotation_degrees = 180
		elif event.keycode == KEY_D:
			new_col += 1
			player_sprite.rotation_degrees = 0

		# Clamp to valid grid range
		if new_row >= 0 and new_row <= 2 and new_col >= 0 and new_col <= 2:
			current_row = new_row
			current_col = new_col
			target_position = grid_positions[current_row][current_col]
			is_moving = true

func _physics_process(delta):
	if is_moving:
		var direction = (target_position - global_position).normalized()
		var distance = global_position.distance_to(target_position)
		var movement = direction * speed * delta

		if movement.length() >= distance:
			global_position = target_position
			is_moving = false
		else:
			move_and_collide(movement)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bombs"):
		call_deferred("restart_scene")

func restart_scene():
	get_tree().reload_current_scene()
	
func apply_powerup(type: String):
	if type == "shield":
		print_debug("shield activated")
