extends Area2D

@onready var _5x_5: Sprite2D = $"../5x5"
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2

var player_ref: Node2D
var blink_started := false

func _ready():
	_5x_5.visible = false
	blink_started = false
	timer.stop()
	timer_2.stop()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_ref = body
		_5x_5.visible = true
		if player_ref.has_method("activate_extended_grid"):
			player_ref.activate_extended_grid()
		timer.start(10.0)  # ← Bu eksikti
		blink_started = false
		position = Vector2(750, 50)

func _on_timer_timeout() -> void:
	if player_ref:
		if player_ref.has_method("is_in_extended_area") and player_ref.is_in_extended_area():
			print("5x5 içindeyken süre doldu, oyun resetleniyor.")
			get_tree().reload_current_scene()
		else:
			if player_ref.has_method("deactivate_extended_grid"):
				player_ref.deactivate_extended_grid()
			_5x_5.visible = false
	timer_2.stop()
	queue_free()

func _on_timer_2_timeout() -> void:
	_5x_5.visible = not _5x_5.visible

func _process(delta: float) -> void:
	if not blink_started and timer.time_left > 0.0 and timer.time_left <= 3.0:
		timer_2.start(0.25)
		blink_started = true
