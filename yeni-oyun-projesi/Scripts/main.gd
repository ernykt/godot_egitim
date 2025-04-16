extends Node2D
@onready var player: Node2D = $Player
@onready var score_label: Label = $ScoreLabel

var score = 0
var powerups = [
	preload("res://Scenes/shield_powerup.tscn"),   # index 0 → Shield
	preload("res://Scenes/5x_5_power_up.tscn")     # index 1 → 5x5
]

func _ready() -> void:
	score_label.text = "score: 0"

var spawn_positions := [
	[Vector2(300, 300), Vector2(450, 300), Vector2(600, 300)],
	[Vector2(300, 450), Vector2(450, 450), Vector2(600, 450)],
	[Vector2(300, 600), Vector2(450, 600), Vector2(600, 600)]
]

# Bu değişkenler sahnede o power-up’tan biri olup olmadığını kontrol eder
var has_active_5x5 := false
var has_active_shield := false

func _spawn_powerup(position: Vector2):
	var index = randi_range(0, 1)

	# Spawn koşulları
	if index == 0 and has_active_shield:
		return
	if index == 1 and has_active_5x5:
		return

	# Power-up sahneye ekleniyor
	var powerup = powerups[index].instantiate()
	powerup.position = position
	add_child(powerup)

	# Aktiflik durumu set edilir ve sahneden çıkınca sıfırlanır
	if index == 0:
		has_active_shield = true
		powerup.tree_exited.connect(func(): has_active_shield = false)
	elif index == 1:
		has_active_5x5 = true
		powerup.tree_exited.connect(func(): has_active_5x5 = false)

func _on_shield_spawn_timer_timeout() -> void:
	var random_row = spawn_positions[randi() % spawn_positions.size()]
	var random_position = random_row[randi() % random_row.size()]
	_spawn_powerup(random_position)

func _on_score_timeout() -> void:
	score += 1
	score_label.text = "score: " + str(score)
